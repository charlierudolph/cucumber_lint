source 'http://rubygems.org'

if ENV['RUBY_TYPE'] == 'JRUBY'
  ruby '2.2.3', engine: 'jruby', engine_version: '9.0.5.0'
else
  ruby '2.3.0'
end

gemspec

group :development do
  gem 'activesupport', '4.2.4'
  gem 'cucumber', '2.3.3'
  gem 'open4', '1.3.4'
  gem 'rake', '10.4.2'
  gem 'rspec', '3.3.0'
  gem 'rubocop', '0.33.0'
end
