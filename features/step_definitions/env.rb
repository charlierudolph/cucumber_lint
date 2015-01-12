require 'cucumber_lint'
require 'open4'
require 'rspec'


BIN_PATH = "#{File.dirname(__FILE__)}/../../bin"
FIXTURES_PATH = "#{File.dirname(__FILE__)}/fixtures"
TMP_DIR = '/tmp'


Before do
  Dir.chdir TMP_DIR
  FileUtils.rm_rf 'features'
  FileUtils.rm_f 'cucumber_lint.yml'
  Dir.mkdir 'features'
end


at_exit do
  FileUtils.rm_rf TMP_DIR
end
