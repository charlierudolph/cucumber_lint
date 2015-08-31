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


    def expected_first_element_start
      spacing = if @description == ''
                  get_config(:between_feature_and_element)
                else
                  get_config(:between_feature_and_description) +
                  @description.count("\n") +
                  get_config(:between_description_and_element) +
                  1
                end

      @feature.line + spacing + 1
    end


    def extra_empty_line line_number, count
      if @config.fix
        count.times do |i|
          add_fix line_number + i, -> (line) { line.sub("\n", '') }
        end
      else
        add_error "#{line_number}: Remove#{" #{count}" if count > 1} empty line#{'s' if count > 1}"
      end
    end


    def get_config key
      @config.consistent_empty_lines.send(key)
    end


    def get_element_end element
      if element.type == 'scenario_outline'
        element.examples.last.rows.last.line
      else
        step_end element.steps.last
      end
    end


    def lint_description
      return if @description == ''

      shared_lines = @feature.line + 1
      expected_start = shared_lines + get_config(:between_feature_and_description)
      actual_start = shared_lines + @description.match(/\n*/)[0].length
      resolve_empty_line_difference actual_start, expected_start
    end


    def lint_elements
      return unless @feature.elements

      expected_element_start = expected_first_element_start
      @feature.elements.each do |element|
        resolve_empty_line_difference element.line, expected_element_start
        lint_scenario_outline_and_examples element if element.type == 'scenario_outline'
        element_end = get_element_end element
        expected_element_start = element_end + get_config(:between_elements) + 1
      end
    end


    def lint_scenario_outline_and_examples element
      expected_start = step_end(element.steps.last) +
                       get_config(:between_scenario_outline_and_examples) +
                       1
      actual_start = element.examples.first.line
      resolve_empty_line_difference actual_start, expected_start
    end


    def missing_empty_line line_number, count
      if @config.fix
        add_fix line_number, -> (line) { "\n" * count + line }
      else
        add_error "#{line_number}: Add#{" #{count}" if count > 1} empty line#{'s' if count > 1}"
      end
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
