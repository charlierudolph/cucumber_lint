module CucumberLint
  # A class representing a user configuration that tries to use an unsupported style
  class UnsupportedStyle < StandardError

    def initialize style, supported_styles, override
      super("#{style} does not support #{override}. Supported: #{supported_styles.join(', ')}")
    end

  end
end
