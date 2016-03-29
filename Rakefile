desc 'Run all linters and specs'
task default: %w(lint:ruby test:unit test:feature test:self)


desc 'Run ruby linters'
task 'lint:ruby' do
  sh 'bundle exec rubocop'
end


desc 'Run feature tests'
task 'test:feature' do
  sh 'bundle exec cucumber -f progress'
end


desc 'Run unit tests'
task 'test:unit' do
  sh 'bundle exec rspec'
end


desc 'Run self test'
task 'test:self' do
  sh 'bundle exec cucumber_lint'
end


desc 'Build the gem'
task build: :default do
  sh 'gem build cucumber_lint.gemspec'
end
