require 'yaml'

module CucumberLint
  # A configuration for executing cucumber_lint
  class Config

    attr_reader :fix

    def initialize dir:, fix:
      @dir = dir
      @fix = fix
      @options = parse_config
    end


    def method_missing method
      @options.send(method)
    end


    private


    def parse_config
      defaults = load_default_config
      overrides = load_config "#{@dir}/cucumber_lint.yml"

      defaults.each_pair do |style, style_options|
        next unless overrides.key?(style)

        if style_options['supported_styles'].include? overrides[style]
          style_options['enforced_style'] = overrides[style]
        else
          fail UnsupportedStyle.new style, style_options['supported_styles'], overrides[style]
        end
      end

      defaults.to_open_struct
    end


    def load_config path
      return {} unless File.exist? path
      YAML.load File.read path
    end


    def load_default_config
      load_config "#{File.dirname(__FILE__)}/../../config/default.yml"
    end

  end
end
