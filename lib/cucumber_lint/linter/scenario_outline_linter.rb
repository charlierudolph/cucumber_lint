module CucumberLint
  # A linter for a series of steps in a scenario outline (as parsed by Gherkin)
  class ScenarioOutlineLinter < Linter

    def initialize steps:, file_lines:, fix:, parent:
      super(fix: fix, parent: parent)

      @steps = steps
      @file_lines = file_lines
    end


    def lint
      @steps.each do |step|
        step.name.scan(/<.+?>/).each do |placeholder|
          bad_placeholder step.line, placeholder unless placeholder == placeholder.upcase
        end
      end
    end


    private


    def bad_placeholder line_number, placeholder
      if @fix
        fix_list.add line_number, -> (line) { line.sub(placeholder, placeholder.upcase) }
      else
        errors << "#{line_number}: Make \"#{placeholder}\" uppercase"
      end
    end

  end
end
