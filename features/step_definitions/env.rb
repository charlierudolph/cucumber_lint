require 'active_support/core_ext/hash/deep_merge.rb'
require 'cucumber_lint'
require 'open4'
require 'rspec'


BIN_PATH = "#{File.dirname(__FILE__)}/../../bin"
CONFIG_PATH = "#{File.dirname(__FILE__)}/fixtures/config/disabled.yml"


Before do
  @tmp_dir = Dir.mktmpdir
  Dir.chdir @tmp_dir
  IO.write 'cucumber_lint.yml', IO.read(CONFIG_PATH)
  Dir.mkdir 'features'
end
