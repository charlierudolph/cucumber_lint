Given(/^I have no files$/) do
  # Empty step for readability
end


Given(/^I have a feature with( formatted)? (.+?)$/) do |formatted, feature_type|
  feature_name = formatted ? 'good' : 'bad'
  feature_type.gsub!(' ', '_')
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


Then(/^the feature with (.+?) is now formatted$/) do |feature_type|
  feature_type.gsub!(' ', '_')
  expected = IO.read("#{FIXTURES_PATH}/#{feature_type}/good.feature.example")
  actual = IO.read "#{TMP_DIR}/features/#{feature_type}.feature"
  expect(actual).to eql expected
end
