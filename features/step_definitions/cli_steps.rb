require 'yaml'


Given(/^I have no files$/) do
  # Empty step for readability
end


Given(/^I have "(.+?)" (enabled|disabled)$/) do |key, value|
  update_config(key => { enabled: value == 'enabled' })
end


Given(/^I have "(.+?)" enabled with "(.+?)" as "(.+?)"$/) do |key, config_key, config_value|
  config_value = config_value.to_i if config_value.match(/^\d*$/)
  update_config(key => { enabled: true, config_key => config_value })
end


Given(/^I have a file without a feature$/) do
  write_feature ''
end

Given(/^I have a feature with content$/) do |content|
  write_feature content.to_s
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
  actual = IO.read feature_path
  expect(actual).to eql content.to_s
end


Then(/^the file has been deleted$/) do
  exists = File.exist? feature_path
  expect(exists).to be_falsy
end
