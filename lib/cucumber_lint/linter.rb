module CucumberLint
  # A base linter, not meant to be instantiated
  class Linter

    def initialize config:, linted_file:
      @config = config
      @linted_file = linted_file
    end


    def add_error *args
      @linted_file.add_error(*args)
    end

  end
end
