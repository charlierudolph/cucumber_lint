Given(/^feature content$/) do |content|
  @content = content
end


Then(/^the formatted feature content is$/) do |content|
  expected = content
  actual = CucumberLint::FeatureFormatter.new(@content).formatted_content
  expect(actual).to eql expected
end


Then(/^the feature is formatted$/) do
  expect(CucumberLint::FeatureFormatter.new(@content)).to be_formatted
end
