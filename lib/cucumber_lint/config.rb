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

    # rubocop:disable Metrics/MethodLength
    def parse_config
      defaults = load_default_config
      overrides = load_config "#{@dir}/cucumber_lint.yml"

      overrides.each_pair do |style, style_overrides|
        style_overrides.each_pair do |key, value|
          if key == 'enforced_style'
            supported = defaults[style]['supported_styles']
            fail UnsupportedStyle.new style, supported, value unless supported.include?(value)
          end

          defaults[style][key] = value
        end
      end

      defaults.to_open_struct
    end
    # rubocop:enable Metrics/MethodLength


    def load_config path
      return {} unless File.exist? path
      YAML.load File.read path
    end


    def load_default_config
      load_config "#{File.dirname(__FILE__)}/../../config/default.yml"
    end

  end
end
