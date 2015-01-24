require 'core_ext/array'
require 'core_ext/basic_object'
require 'core_ext/hash'
require 'gherkin/formatter/json_formatter'
require 'gherkin/parser/parser'
require 'multi_json'

module CucumberLint
  # A linter for a given feature (represented by a filename)
  class FeatureLinter < Linter

    def lint
      features = parse_content

      features.each do |feature|
        lint_feature feature
      end

      empty_feature if features.count == 0
    end

    private


    def empty_feature
      return unless @config.no_empty_features.enabled

      if @config.fix
        @linted_file.mark_for_deletion
      else
        add_error ' Remove file with no feature'
      end
    end


    def lint_examples examples
      examples.each { |example| lint_table example.rows }
    end


    def lint_feature feature
      feature.elements.each do |element|
        lint_steps element.steps

        if element.type == 'scenario_outline'
          lint_scenario_outline element.steps
          lint_examples element.examples
        end
      end
    end


    def lint_scenario_outline steps
      linter = ScenarioOutlineLinter.new linter_options.merge(steps: steps)
      linter.lint
    end


    def lint_steps steps
      linter = StepsLinter.new linter_options.merge(steps: steps)
      linter.lint
    end


    def lint_table rows
      linter = TableLinter.new linter_options.merge(rows: rows)
      linter.lint
    end


    def linter_options
      { config: @config, linted_file: @linted_file }
    end


    def parse_content
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)
      parser.parse(@linted_file.content, '', 0)
      formatter.done
      MultiJson.load(io.string).to_open_struct
    end

  end
end
