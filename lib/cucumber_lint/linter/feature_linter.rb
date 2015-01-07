require 'core_ext/hash'
require 'gherkin/formatter/json_formatter'
require 'gherkin/parser/parser'
require 'multi_json'

module CucumberLint
  # A linter for a given feature (represented by a filename)
  class FeatureLinter < Linter

    attr_reader :errors, :fix_list

    def initialize path, fix:
      super(fix: fix)

      @path = path
      @content = IO.read(path)
      @file_lines = @content.lines
    end


    def can_fix?
      !fix_list.empty?
    end


    def errors?
      !errors.empty?
    end


    def lint
      feature = parse_content

      feature.elements.each do |element|
        lint_steps element.steps

        (element.examples || []).each do |example|
          lint_table example.rows
        end
      end

      errors.map! { |error| "#{feature.uri}:#{error}" }
    end

    def write
      fixed_content = fix_list.apply(@file_lines).join
      IO.write(@path, fixed_content)
    end

    private


    def lint_steps steps
      steps_linter = StepsLinter.new steps: steps, file_lines: @file_lines, fix: @fix, parent: self
      steps_linter.lint
    end


    def lint_table rows
      table_linter = TableLinter.new rows: rows, file_lines: @file_lines, fix: @fix, parent: self
      table_linter.lint
    end


    def parse_content
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)
      parser.parse(@content, @path, 0)
      formatter.done
      MultiJson.load(io.string)[0].to_open_struct
    end

  end
end
