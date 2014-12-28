Given(/^I have no files$/) do
  # Empty step for readability
end


Given(/^I have an? (.+?) file at "features\/(.+?)"$/) do |filetype, filename|
  content = IO.read("#{FIXTURES_PATH}/#{filetype}.feature.example")
  IO.write "#{TMP_DIR}/features/#{filename}", content
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


Then(/^the file "features\/(.+?)" in now formatted$/) do |filename|
  expected = IO.read "#{FIXTURES_PATH}/formatted.feature.example"
  actual = IO.read "#{TMP_DIR}/features/#{filename}"
  expect(actual).to eql expected
end
