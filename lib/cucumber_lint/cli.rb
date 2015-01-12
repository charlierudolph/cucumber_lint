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

      opts = extract_args args
      @config = load_config fix: opts[:fix]
      @results = OpenStruct.new(total: 0, passed: 0, failed: 0, written: 0, errors: [])
    end


    def execute!
      Dir.glob('./features/**/*.feature').sort.each do |filename|
        lint_feature filename
      end

      output_results
      exit 1 unless @results.errors.empty?
    end

    private

    def lint_feature filename
      linter = FeatureLinter.new filename, config: @config
      linter.lint

      if linter.errors?
        @results.errors += linter.errors
        file_failed
      elsif linter.can_fix?
        file_written
      else
        file_passed
      end

      linter.write if linter.can_fix?
    end


    def load_config fix:
      Config.new dir: Pathname.new('.').realpath, fix: fix
    rescue UnsupportedStyle => e
      @out.puts e.message.red
      exit 1
    end


    def extract_args args
      valid_args = ['--fix']

      if (args - valid_args).empty?
        { fix: args.count == 1 }
      else
        @out.puts "error: unsupported option(s): #{args.join(' ')}".red
        @out.puts 'usage: cucumber_lint'
        @out.puts '   or: cucumber_lint --fix'
        exit 1
      end
    end


    def file_counts
      out = ["#{@results.passed} passed".green]
      out << "#{@results.written} written".yellow if @results.written > 0
      out << "#{@results.failed} failed".red if @results.failed > 0
      "(#{out.join(', ')})"
    end


    def output_errors
      @out.print "\n\n"
      @out.print @results.errors.join("\n").red
    end


    def output_counts
      @out.print "\n\n"
      @out.print "#{@results.total} file#{'s' if @results.total != 1} inspected"
      @out.print " #{file_counts}" if @results.total > 0
      @out.print "\n"
    end


    def output_results
      output_errors unless @results.errors.empty?
      output_counts
    end


    def file_passed
      @results.total += 1
      @results.passed += 1
      @out.print '.'.green
    end


    def file_failed
      @results.total += 1
      @results.failed += 1
      @out.print 'F'.red
    end


    def file_written
      @results.total += 1
      @results.written += 1
      @out.print 'W'.yellow
    end

  end
end
