require 'yaml'


Given(/^I have no files$/) do
  # Empty step for readability
end


Given(/^I have (.+?) (enabled|disabled)$/) do |key, value|
  config = YAML.load IO.read "#{TMP_DIR}/cucumber_lint.yml"
  config[key]['enabled'] = value == 'enabled'
  IO.write "#{TMP_DIR}/cucumber_lint.yml", config.to_yaml
end


Given(/^I have (.+?) enforcing (.+?)$/) do |key, value|
  config = YAML.load IO.read "#{TMP_DIR}/cucumber_lint.yml"
  config[key]['enabled'] = true
  config[key]['enforced_style'] = value
  IO.write "#{TMP_DIR}/cucumber_lint.yml", config.to_yaml
end



Given(/^I have configured (.+?) to enforce (.+?)$/) do |key, value|
  config = { key => value }
  IO.write "#{TMP_DIR}/cucumber_lint.yml", config.to_yaml
end


Given(/^I have a feature with (unformatted|formatted) (.+?)$/) do |format, type|
  feature_name = format == 'formatted' ? 'good' : 'bad'
  feature_type = type.gsub(' (', '/').gsub(')', '').gsub(' ', '_').split('/')
  content = IO.read("#{FIXTURES_PATH}/#{feature_type.join('/')}/#{feature_name}.feature.example")
  IO.write "#{TMP_DIR}/features/test.feature", content
end


Given(/^I have a file without a feature$/) do
  IO.write "#{TMP_DIR}/features/test.feature", ''
end

Given(/^I have a feature with content$/) do |content|
  IO.write "#{TMP_DIR}/features/test.feature", content
end




When(/^I run `(.+?)`$/) do |command|
  @last_run = run command
end




Then(/^I see the output$/) do |output|
  expect(@last_run.out.uncolorize).to eql "#{output}\n"
end


Then(/^it exits with status (\d+)$/) do |status|
  expect(@last_run.exit_status).to eql status.to_i
end


Then(/^I now have a feature with formatted (.+?)$/) do |type|
  feature_type = type.gsub(' (', '/').gsub(')', '').gsub(' ', '_').split('/')
  expected = IO.read("#{FIXTURES_PATH}/#{feature_type.join('/')}/good.feature.example")
  actual = IO.read "#{TMP_DIR}/features/test.feature"
  expect(actual).to eql expected
end

Then(/^my feature now has content$/) do |content|
  actual = IO.read "#{TMP_DIR}/features/test.feature"
  expect(actual).to eql content
end


Then(/^the file has been deleted$/) do
  exists = File.exist? "#{TMP_DIR}/features/test.feature"
  expect(exists).to be_falsy
end
