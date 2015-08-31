require 'yaml'


Given(/^I have no files$/) do
  # Empty step for readability
end


Given(/^I have "(.+?)" (enabled|disabled)$/) do |key, value|
  config = YAML.load IO.read "#{TMP_DIR}/cucumber_lint.yml"
  config[key]['enabled'] = value == 'enabled'
  IO.write "#{TMP_DIR}/cucumber_lint.yml", config.to_yaml
end


Given(/^I have "(.+?)" enabled with "(.+?)" as "(.+?)"$/) do |key, configKey, configValue|
  config = YAML.load IO.read "#{TMP_DIR}/cucumber_lint.yml"
  config[key]['enabled'] = true
  config[key][configKey] = configValue
  IO.write "#{TMP_DIR}/cucumber_lint.yml", config.to_yaml
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


Then(/^it passes$/) do
  expect(@last_run.exit_status).to eql 0
end


Then(/^it fails with$/) do |failureTable|
  expected_text = failureTable.hashes.map do |row|
    identifer = './features/test.feature'
    identifer += ":#{row['LINE']}" if row['LINE']
    "#{identifer}: #{row['MESSAGE']}"
  end.join "\n"
  expect(@last_run.out.uncolorize).to include expected_text
  expect(@last_run.exit_status).to eql 1
end


Then(/^I see the output$/) do |output|
  expect(@last_run.out.uncolorize).to eql "#{output}\n"
end


Then(/^it exits with status (\d+)$/) do |status|
  expect(@last_run.exit_status).to eql status.to_i
end


Then(/^my feature now has content$/) do |content|
  actual = IO.read "#{TMP_DIR}/features/test.feature"
  expect(actual).to eql content
end


Then(/^the file has been deleted$/) do
  exists = File.exist? "#{TMP_DIR}/features/test.feature"
  expect(exists).to be_falsy
end
