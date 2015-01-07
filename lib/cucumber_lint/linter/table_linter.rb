require 'gherkin/formatter/pretty_formatter'

module CucumberLint
  # A linter for a series of table rows (as parsed by Gherkin)
  class TableLinter < Linter

    def initialize rows:, file_lines:, fix:, parent:
      super(fix: fix, parent: parent)

      @rows = rows
      @file_lines = file_lines
    end


    def lint
      bad_whitespace unless actual_table_lines == expected_table_lines
    end


    private


    def actual_table_lines
      @actual_table_lines ||= determine_actual_table_lines
    end


    def bad_whitespace
      if @fix
        @rows.each_with_index.map do |row, index|
          fix_list.add row.line, -> (line) { line.gsub(/\|.+?\n/, expected_table_lines[index]) }
        end
      else
        errors << "#{@rows[0].line}: Fix table whitespace"
      end
    end


    def determine_actual_table_lines
      @rows.map { |row| @file_lines[row.line - 1].lstrip }
    end


    def determine_expected_table_lines
      @rows.each { |row| row.comments = [] }

      io = StringIO.new
      formatter = Gherkin::Formatter::PrettyFormatter.new(io, false, false)
      formatter.table(@rows)
      formatter.done
      io.string.lines.map(&:lstrip)
    end


    def expected_table_lines
      @expected_table_lines ||= determine_expected_table_lines
    end

  end
end
