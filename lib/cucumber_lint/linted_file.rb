require 'pathname'

module CucumberLint
  # A class that represents a file being linted
  class LintedFile

    attr_reader :content, :errors, :lines

    def initialize path
      @path = Pathname.new path
      @content = IO.read path
      @lines = @content.lines

      @errors = []
    end


    def add_error error
      @errors << error
    end


    def error_messages exclude_fixes
      errors.map do |error|
        next if error[:fix] && exclude_fixes
        location = @path.to_s
        location += ":#{error[:line_number]}" if error[:line_number]
        location + ": #{error[:message]}"
      end.compact
    end


    def resolve_lint
      errors.empty? ? :passed : :failed
    end


    def resolve_fix
      if errors.empty?
        :passed
      else
        fix
        unfixable_errors? ? :failed : :written
      end
    end


    private


    def apply_fixes
      fixable_errors.each do |error|
        fixes = error[:fixes] || [error]
        fixes.each do |fix|
          index = fix[:line_number] - 1
          lines[index] = fix[:fix].call lines[index]
        end
      end
    end


    def fix
      apply_fixes
      IO.write @path, lines.join
    end


    def fixable_errors
      errors.select { |error| error.key?(:fix) || error.key?(:fixes) }
    end


    def unfixable_errors?
      errors.length != fixable_errors.length
    end

  end
end
