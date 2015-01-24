require 'cucumber_lint'
require 'open4'
require 'rspec'


BIN_PATH = "#{File.dirname(__FILE__)}/../../bin"
FIXTURES_PATH = "#{File.dirname(__FILE__)}/fixtures"
TMP_DIR = '/tmp'


Before do
  Dir.chdir TMP_DIR
  FileUtils.rm_rf 'features'
  IO.write 'cucumber_lint.yml', IO.read("#{FIXTURES_PATH}/config/disabled.yml")
  Dir.mkdir 'features'
end


at_exit do
  FileUtils.rm_rf TMP_DIR
end
