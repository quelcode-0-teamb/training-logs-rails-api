source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'pg', '>= 0.18', '< 2.0', group: :production
gem 'puma', '~> 4.3'
gem 'bcrypt', '~> 3.1.7'
gem 'seed-fu'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'rack-cors'
gem 'active_model_serializers'
gem 'enumerize'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bullet'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'annotate'
end

group :test do
  gem 'rspec_junit_formatter'
end
