require 'core_ext/array'

module CucumberLint
  # A class that takes in the content that make up a cucumber feature
  # and can determine if it is formatted and output the formatted content
  class FeatureFormatter

    attr_reader :formatted_content

    def initialize content
      @content = content
      @formatted_content = format
    end


    def formatted?
      @content == @formatted_content
    end


    private


    def format
      lines = format_steps @content.split("\n", -1)
      groupings = lines.group { |line| line =~ /^\s*\|/ }

      groupings.map do |group|
        if group[:passing]
          format_table group[:values]
        else
          group[:values]
        end
      end.flatten.join("\n")
    end


    def format_table lines
      TableFormatter.new(lines).formatted_content
    end


    def format_steps steps
      StepsFormatter.new(steps).formatted_content
    end

  end
end
