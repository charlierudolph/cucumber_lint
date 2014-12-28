module CucumberLint
  # A class that takes in the lines of a cucumber feature
  # and can determine if the steps are formatted and output the formatted steps
  class StepsFormatter

    attr_reader :formatted_content

    def initialize lines
      @lines = lines
      @formatted_content = format
    end


    def formatted?
      @lines == @formatted_content
    end

    private

    RESET_KEYWORDS = %w(Background Scenario)
    STEP_TYPES = %w(Given When Then)

    def format
      @lines.map { |line| format_line line }
    end


    def format_line line
      @previous_step_type = nil if should_reset_previous_step_type? line

      step_type = line.split(' ', -1)[0]

      if STEP_TYPES.include?(step_type)
        if @previous_step_type == step_type
          line.sub! step_type, 'And'
        else
          @previous_step_type = step_type
        end
      end

      line
    end


    def should_reset_previous_step_type? line
      RESET_KEYWORDS.any? { |keyword| line.start_with? keyword }
    end

  end
end
