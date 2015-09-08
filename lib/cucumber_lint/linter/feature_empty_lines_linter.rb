module CucumberLint
  # A linter for a given feature's empty lines
  class FeatureEmptyLinesLinter < Linter

    def initialize config:, feature:, linted_file:
      super config: config, linted_file: linted_file

      @feature = feature
      @description = feature.description
    end


    def lint
      lint_description
      lint_elements
    end


    private


    def config_value key
      @config.consistent_empty_lines.send(key)
    end


    def element_end element
      if element.type == 'scenario_outline'
        element.examples.last.rows.last.line
      else
        step_end element.steps.last
      end
    end


    def element_start element
      if element.tags
        element.tags[0].line
      else
        element.line
      end
    end


    def expected_first_element_start
      spacing = if @description == ''
                  config_value(:between_feature_and_element)
                else
                  @description.count("\n") +
                  config_value(:between_description_and_element) +
                  1
                end

      @feature.line + spacing + 1
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


    def lint_description
      return if @description == ''

      shared_lines = @feature.line + 1
      expected_start = shared_lines + config_value(:between_feature_and_description)
      actual_start = shared_lines + @description.match(/\n*/)[0].length
      resolve_empty_line_difference actual_start, expected_start
    end


    def lint_elements
      return unless @feature.elements

      expected_element_start = expected_first_element_start
      @feature.elements.each do |element|
        resolve_empty_line_difference element_start(element), expected_element_start
        lint_scenario_outline_and_examples element if element.type == 'scenario_outline'
        expected_element_start = element_end(element) + config_value(:between_elements) + 1
      end
    end


    def lint_scenario_outline_and_examples element
      expected_start = step_end(element.steps.last) +
                       config_value(:between_scenario_outline_and_examples) +
                       1
      actual_start = element.examples.first.line
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


    def step_end step
      rows = step.rows
      doc_string = step.doc_string

      if rows && rows.is_a?(Array)
        rows.last.line
      elsif doc_string
        doc_string.line + doc_string.value.count("\n") + 2
      else
        step.line
      end
    end

  end
end
