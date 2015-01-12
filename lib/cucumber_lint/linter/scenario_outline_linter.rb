require 'core_ext/string'

module CucumberLint
  # A linter for a series of steps in a scenario outline (as parsed by Gherkin)
  class ScenarioOutlineLinter < Linter

    def initialize steps:, file_lines:, config:, parent:
      super config: config, parent: parent

      @steps = steps
      @file_lines = file_lines
      @header_style = @config.table_headers.enforced_style.to_sym
    end


    def lint
      @steps.each do |step|
        step.name.scan(/<.+?>/).each do |placeholder|
          report_bad_placeholder step.line, placeholder if bad_placeholder? placeholder
        end
      end
    end


    private


    def bad_placeholder? str
      str != str.public_send(@header_style)
    end


    def report_bad_placeholder line_number, str
      if @config.fix
        fix_list.add line_number, -> (line) { line.sub(str, str.public_send(@header_style)) }
      else
        errors << "#{line_number}: #{@header_style} \"#{str}\""
      end
    end

  end
end
