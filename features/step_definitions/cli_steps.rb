Given(/^I have no files$/) do
  # Empty step for readability
end


Given(/^I have a feature with (unformatted|formatted) (.+?)$/) do |format, type|
  feature_name = format == 'formatted' ? 'good' : 'bad'
  feature_type = type.gsub(' ', '_')
  content = IO.read("#{FIXTURES_PATH}/#{feature_type}/#{feature_name}.feature.example")
  IO.write "#{TMP_DIR}/features/#{feature_type}.feature", content
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
  feature_type = type.gsub(' ', '_')
  expected = IO.read("#{FIXTURES_PATH}/#{feature_type}/good.feature.example")
  actual = IO.read "#{TMP_DIR}/features/#{feature_type}.feature"
  expect(actual).to eql expected
end
