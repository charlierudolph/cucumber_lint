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
      @results = OpenStruct.new(total: 0, passed: 0, failed: 0, written: 0, deleted: 0, errors: [])
    end


    def execute!
      Dir.glob('./features/**/*.feature').sort.each do |filename|
        lint_feature filename
      end

      output_results
      exit 1 unless @results.errors.empty?
    end


    private


    def add_result status, errors
      @results.total += 1
      @results[status] += 1
      @results.errors += errors
      @out.print output_for_status(status)
    end


    def lint_feature filename
      linted_file = LintedFile.new filename

      linter = FeatureLinter.new config: @config, linted_file: linted_file
      linter.lint

      add_result linted_file.resolve, linted_file.errors
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


    # rubocop:disable Metrics/AbcSize
    def file_counts
      [:passed, :written, :deleted, :failed].map do |status|
        if status == :passed || @results[status] > 0
          "#{@results[status]} #{status}".colorize(output_color_for status)
        end
      end.compact.join(', ')
    end
    # rubocop:enable Metrics/AbcSize


    def output_errors
      @out.print "\n\n"
      @out.print @results.errors.join("\n").red
    end


    def output_counts
      @out.print "\n\n"
      @out.print "#{@results.total} file#{'s' if @results.total != 1} inspected"
      @out.print " (#{file_counts})" if @results.total > 0
      @out.print "\n"
    end


    def output_results
      output_errors unless @results.errors.empty?
      output_counts
    end

    def output_color_for status
      case status
      when :passed then :green
      when :failed then :red
      else :yellow
      end
    end

    def output_letter_for status
      case status
      when :passed then '.'
      when :failed then 'F'
      when :written then 'W'
      when :deleted then 'D'
      end
    end

    def output_for_status status
      output_letter_for(status).colorize output_color_for(status)
    end

  end
end
