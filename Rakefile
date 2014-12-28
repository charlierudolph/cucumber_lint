desc 'Run all linters and specs'
task default: %w(lint spec features)


desc 'Run linters'
task :lint do
  sh 'bundle exec rubocop'
end

desc 'Run specs'
task :spec do
  sh 'bundle exec rspec'
end

desc 'Run features'
task :features do
  sh 'bundle exec cucumber'
end


desc 'Build the gem'
task build: :default do
  sh 'gem build cucumber_lint.gemspec'
end
