require 'core_ext/string'
require 'gherkin/formatter/pretty_formatter'
require 'stringio'

module CucumberLint
  # A linter for a series of table rows (as parsed by Gherkin)
  class TableLinter < Linter

    def initialize rows:, config:, linted_file:
      super config: config, linted_file: linted_file

      @rows = rows
      @header_style = @config.consistent_table_headers.enforced_style.to_sym
    end


    def lint
      inconsistent_table_whitespace unless actual_table_lines == expected_table_lines
      inconsistent_table_headers if inconsistent_table_headers?
    end


    private


    def inconsistent_table_headers
      return unless @config.consistent_table_headers.enabled

      if @config.fix
        add_fix @rows[0].line, -> (line) { line.split('|', -1).map(&@header_style).join('|') }
      else
        add_error "#{@rows[0].line}: #{@header_style} table headers"
      end
    end


    def inconsistent_table_headers?
      headers = actual_table_lines[0].split('|')
      headers != headers.map(&@header_style)
    end


    def actual_table_lines
      @actual_table_lines ||= determine_actual_table_lines
    end


    def inconsistent_table_whitespace
      return unless @config.consistent_table_whitespace.enabled

      if @config.fix
        @rows.each_with_index.map do |row, index|
          add_fix row.line, -> (line) { line.gsub(/\|.*\|/, expected_table_lines[index]) }
        end
      else
        add_error "#{@rows[0].line}: Fix table whitespace"
      end
    end


    def determine_actual_table_lines
      @rows.map { |row| @linted_file.lines[row.line - 1].strip }
    end


    def determine_expected_table_lines
      @rows.each { |row| row.comments = [] }

      io = StringIO.new
      formatter = Gherkin::Formatter::PrettyFormatter.new(io, false, false)
      formatter.table(@rows)
      formatter.done
      io.string.lines.map(&:strip)
    end


    def expected_table_lines
      @expected_table_lines ||= determine_expected_table_lines
    end

  end
end
