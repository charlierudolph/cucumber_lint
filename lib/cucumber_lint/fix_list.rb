module CucumberLint
  # A class that represents a list of fixes to apply to a feature
  class FixList

    attr_reader :list


    def initialize
      @list = {}
    end


    def add line_number, fix
      @list[line_number] ||= []
      @list[line_number] += Array(fix)
    end


    def apply lines
      lines.each_with_index.map do |line, index|
        line_number = index + 1

        @list.fetch(line_number, []).each do |fix|
          line = fix.call(line)
        end

        line
      end
    end


    def empty?
      @list.empty?
    end

  end
end
