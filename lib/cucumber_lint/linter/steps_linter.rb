module CucumberLint
  # A linter for a series of steps (as parsed by Gherkin)
  class StepsLinter < Linter

    def initialize steps:, file_lines:, fix:, parent:
      super(fix: fix, parent: parent)

      @steps = steps
      @file_lines = file_lines
    end


    def lint
      previous_keyword = nil

      @steps.each do |step|
        current_keyword = step.keyword.strip

        if STEP_TYPES.include?(current_keyword) && current_keyword == previous_keyword
          repeated_keyword step.line, current_keyword
        else
          previous_keyword = current_keyword
        end

        lint_table(step.rows) if step.rows && step.rows.is_a?(Array)
      end
    end


    private

    STEP_TYPES = %w(Given When Then)

    def repeated_keyword line_number, keyword
      if @fix
        fix_list.add line_number, -> (line) { line.sub(keyword, 'And') }
      else
        errors << "#{line_number}: Use \"And\" instead of repeating \"#{keyword}\""
      end
    end


    def lint_table rows
      table_linter = TableLinter.new rows: rows, file_lines: @file_lines, fix: @fix, parent: self
      table_linter.lint
    end

  end
end
