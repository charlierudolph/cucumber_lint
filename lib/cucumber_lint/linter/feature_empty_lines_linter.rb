module CucumberLint
  # A linter for a given feature's empty lines
  class FeatureEmptyLinesLinter < Linter

    def initialize config:, feature:, linted_file:
      super config: config, linted_file: linted_file

      @feature = feature
    end


    def lint
      return unless @feature.scenarioDefinitions

      expected_element_start = nil
      @feature.scenarioDefinitions.each do |element|
        if expected_element_start
          resolve_empty_line_difference element_start(element), expected_element_start
        end
        lint_scenario_outline_and_examples element if element.type == :ScenarioOutline
        expected_element_start = element_end(element) + config_value(:between_elements) + 1
      end
    end


    private


    def config_value key
      @config.consistent_empty_lines.send(key)
    end


    def element_end element
      if element.type == :ScenarioOutline
        element.examples.last.tableBody.last.location.line
      else
        step_end element.steps.last
      end
    end


    def element_start element
      if element.tags.length > 0
        element.tags[0].location.line
      else
        element.location.line
      end
    end


    def extra_empty_line line_number, count
      fixes = count.times do |i|
        { fix: -> (line) { line.sub("\n", '') },
          line_number: line_number + i }
      end

      add_error(
        fixes: fixes,
        line_number: line_number,
        message: "Remove#{" #{count}" if count > 1} empty line#{'s' if count > 1}"
      )
    end


    def lint_scenario_outline_and_examples element
      expected_start = step_end(element.steps.last) +
                       config_value(:between_scenario_outline_and_examples) +
                       1
      actual_start = element.examples.first.location.line
      resolve_empty_line_difference actual_start, expected_start
    end


    def missing_empty_line line_number, count
      add_error(
        fix: -> (line) { "\n" * count + line },
        line_number: line_number,
        message: "Add#{" #{count}" if count > 1} empty line#{'s' if count > 1}"
      )
    end


    def resolve_empty_line_difference actual, expected
      if actual < expected
        missing_empty_line actual, expected - actual
      elsif actual > expected
        extra_empty_line expected, actual - expected
      end
    end


    def step_argument_end argument
      if argument.type == :DataTable
        argument.rows.last.location.line
      elsif argument.type == :DocString
        argument.location.line + argument.content.count("\n") + 2
      end
    end


    def step_end step
      if step.argument
        step_argument_end step.argument
      else
        step.location.line
      end
    end

  end
end
