Given(/^table lines$/) do |lines|
  @lines = lines.split("\n", -1)
end


Then(/^the formatted table lines are$/) do |lines|
  expected = lines.split("\n", -1)
  actual = CucumberLint::TableFormatter.new(@lines).formatted_content
  expect(actual).to eql expected
end


Then(/^the table is formatted$/) do
  expect(CucumberLint::TableFormatter.new(@lines)).to be_formatted
end
