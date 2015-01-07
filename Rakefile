desc 'Run all linters and specs'
task default: %w(lint features)


desc 'Run all linters and specs'
task lint: %w(lint:ruby lint:cucumber)


desc 'Run ruby linters'
task 'lint:ruby' do
  sh 'bundle exec rubocop'
end


desc 'Run cucumber linters'
task 'lint:cucumber' do
  sh 'bundle exec cucumber_lint'
end


desc 'Run features'
task :features do
  sh 'bundle exec cucumber'
end


desc 'Build the gem'
task build: :default do
  sh 'gem build cucumber_lint.gemspec'
end
