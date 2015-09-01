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
      @fixes = {}
      @marked_for_deletion = false
    end


    def add_error error
      @errors << "#{@path}:#{error}"
    end


    def add_fix line_number, fix
      @fixes[line_number] ||= []
      @fixes[line_number] += Array(fix)
    end


    def mark_for_deletion
      @marked_for_deletion = true
    end


    def resolve
      if @marked_for_deletion
        delete
        :deleted
      elsif !errors.empty? || fixable?
        fix
        errors.empty? ? :written : :failed
      else
        :passed
      end
    end


    private


    def apply_fixes
      lines.each_with_index.map do |line, index|
        line_number = index + 1

        @fixes.fetch(line_number, []).each do |fix|
          line = fix.call(line)
        end

        line
      end
    end


    def delete
      @path.delete
    end


    def fix
      IO.write @path, apply_fixes.join
    end

    def fixable?
      !@fixes.empty?
    end

  end
end
