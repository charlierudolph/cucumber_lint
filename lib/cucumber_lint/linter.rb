module CucumberLint
  # A base linter, not meant to be instantiated
  class Linter

    attr_reader :errors, :fix_list


    def initialize fix:, parent: nil
      @fix = fix

      if parent
        @errors = parent.errors
        @fix_list = parent.fix_list
      else
        @errors = []
        @fix_list = FixList.new
      end
    end

  end
end
