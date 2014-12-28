require 'colorize'
require 'ostruct'

module CucumberLint
  # A class that takes in the content that make up a cucumber feature
  # and can determine if it is formatted and output the formatted content
  class Cli

    def self.execute args
      new(args).execute!
    end


    def initialize args, out: STDOUT
      @out = out
      @lint = args[0] != '--fix'
      @results = OpenStruct.new(formatted: 0, unformatted: 0, unformatted_files: [])
    end


    def execute!
      Dir.glob('./features/**/*.feature').each do |filename|
        formatter = FeatureFormatter.new IO.read(filename)

        if formatter.formatted?
          file_formatted
        else
          file_unformatted filename, formatter.formatted_content
        end
      end

      output_results
      exit 1 unless @results.unformatted_files.empty?
    end

    def output_results
      output_failures if @lint && !@results.unformatted_files.empty?
      total = @results.formatted + @results.unformatted
      @out.print "\n\n#{total} file#{'s' if total != 1} inspected ("
      if @lint
        output_inspect_results
      else
        output_write_results
      end
      @out.puts ')'
    end


    def output_inspect_results
      @out.print "#{@results.formatted} passed".green
      @out.print ', ' + "#{@results.unformatted} failed".red if @results.unformatted > 0
    end


    def output_write_results
      @out.print "#{@results.unformatted} written".yellow
    end


    def output_failures
      @out.puts "\n\nFiles with errors:".red
      @out.print @results.unformatted_files.join("\n").red
    end


    def file_formatted
      @results.formatted += 1
      @out.print '.'.green
    end


    def file_unformatted filename, content
      @results.unformatted += 1

      if @lint
        @results.unformatted_files << filename
        @out.print 'F'.red
      else
        IO.write filename, content
        @out.print 'W'.yellow
      end
    end

  end
end
