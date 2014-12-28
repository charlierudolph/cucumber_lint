module CucumberLint
  # A class that takes in the lines that make up a cucumber table
  # and can determine if it is formatted and output the formatted table
  class TableFormatter

    attr_reader :formatted_content

    def initialize lines
      @lines = lines
      @column_widths = column_widths
      @formatted_content = format
    end


    def formatted?
      @lines == @formatted_content
    end


    private


    def column_widths
      widths_by_line = @lines.map { |line| line_column_widths line }
      grouped_widths = widths_by_line[0].zip(*widths_by_line[1..-1])
      grouped_widths.each_with_index.map do |width, i|
        i == 0 ? width.min : width.max
      end
    end


    def format
      @lines.each_with_index.map do |line|
        line.split('|', -1).each_with_index.map do |piece, index|
          format_piece piece, index
        end.join('|')
      end
    end


    def format_piece piece, index
      if index == 0
        ' ' * column_widths[index]
      elsif index == column_widths.length - 1
        piece
      else
        " #{piece.strip} ".ljust column_widths[index]
      end
    end


    def line_column_widths line
      pieces = line.split('|', -1)
      pieces.each_with_index.map do |piece, index|
        if index == 0 || index == pieces.length - 1
          piece.length
        else
          piece.strip!
          piece.length + 2 # one space padding on each side
        end
      end
    end

  end
end
