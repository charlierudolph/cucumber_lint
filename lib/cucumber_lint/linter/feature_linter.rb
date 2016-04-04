require 'core_ext/to_open_struct'
require 'gherkin/parser'

module CucumberLint
  # A linter for a given feature (represented by a filename)
  class FeatureLinter < Linter

    def lint
      feature = parse_content
      lint_feature_empty_lines feature if @config.consistent_empty_lines.enabled
      lint_elements feature
    rescue Gherkin::CompositeParserException => error
      add_error(message: error.message)
    end

    private

    def lint_examples examples
      examples.each do |example|
        rows = [example.tableHeader] + example.tableBody
        lint_table rows
      end
    end


    def lint_elements feature
      return unless feature.scenarioDefinitions

      feature.scenarioDefinitions.each do |element|
        lint_steps element.steps

        if element.type == :ScenarioOutline
          lint_scenario_outline element.steps
          lint_examples element.examples
        end
      end
    end


    def lint_feature_empty_lines feature
      linter = FeatureEmptyLinesLinter.new linter_options.merge(feature: feature)
      linter.lint
    end


    def lint_scenario_outline steps
      linter = ScenarioOutlineLinter.new linter_options.merge(steps: steps)
      linter.lint
    end


    def lint_steps steps
      linter = StepsLinter.new linter_options
      linter.lint steps
    end


    def lint_table rows
      linter = TableLinter.new linter_options.merge(rows: rows)
      linter.lint
    end


    def linter_options
      { config: @config, linted_file: @linted_file }
    end


    def parse_content
      parser = Gherkin::Parser.new
      feature = parser.parse @linted_file.content
      feature.to_open_struct
    end

  end
end
