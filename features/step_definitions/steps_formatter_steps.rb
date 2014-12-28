Given(/^steps$/) do |steps|
  @steps = steps.split("\n", -1)
end


Then(/^the formatted steps are$/) do |steps|
  expected = steps.split("\n", -1)
  actual = CucumberLint::StepsFormatter.new(@steps).formatted_content
  expect(actual).to eql expected
end


Then(/^the steps are formatted$/) do
  expect(CucumberLint::StepsFormatter.new(@steps)).to be_formatted
end
