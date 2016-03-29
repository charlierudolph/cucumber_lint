require 'cucumber_lint'

describe CucumberLint::StepsLinter do
  describe 'lint' do
    before(:each) do
      @config = double 'config', no_repeating_keywords: double(enabled: true)
      @linted_file = double 'linted_file', add_error: nil
      @steps_linter = CucumberLint::StepsLinter.new config: @config, linted_file: @linted_file
    end

    describe 'keywords' do
      describe 'no repeated keywords' do
        before(:each) do
          @steps = [
            double(argument: nil, keyword: 'Given '),
            double(argument: nil, keyword: 'And '),
            double(argument: nil, keyword: 'When '),
            double(argument: nil, keyword: 'And '),
            double(argument: nil, keyword: 'Then '),
            double(argument: nil, keyword: 'And ')
          ]
        end

        it 'does not add any errors' do
          @steps_linter.lint @steps
          expect(@linted_file).not_to have_received(:add_error)
        end
      end

      describe 'repeated keywords' do
        before(:each) do
          @steps = [
            double(argument: nil, keyword: 'Given '),
            double(argument: nil, keyword: 'Given ', location: double(line: 2)),
            double(argument: nil, keyword: 'When '),
            double(argument: nil, keyword: 'When ', location: double(line: 4)),
            double(argument: nil, keyword: 'Then '),
            double(argument: nil, keyword: 'Then ', location: double(line: 6))
          ]
        end

        it 'does not add any errors' do
          @steps_linter.lint @steps
          expect(@linted_file).to have_received(:add_error).exactly(3).times
          expect(@linted_file).to have_received(:add_error).with(
            hash_including(
              line_number: 2,
              message: "Use \"And\" instead of repeating \"Given\""
            )
          )
          expect(@linted_file).to have_received(:add_error).with(
            hash_including(
              line_number: 4,
              message: "Use \"And\" instead of repeating \"When\""
            )
          )
          expect(@linted_file).to have_received(:add_error).with(
            hash_including(
              line_number: 6,
              message: "Use \"And\" instead of repeating \"Then\""
            )
          )
        end
      end
    end
  end
end
