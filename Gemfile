source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.2'

gem 'rails', '5.1.4'
gem 'pg', '~> 0.19.0', group: :production
gem 'rails-flog'
gem 'rails-i18n'

gem 'slim-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'simple_form'
gem 'i18n-js'
gem 'rmagick', require: 'RMagick'
gem 'fog'
gem 'carrierwave'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'seed-fu'
gem 'config'
gem 'bcrypt'
gem 'puma'
gem 'annotate'
gem 'meta-tags'
gem 'sitemap_generator'
gem 'cancancan'
gem 'date_validator'
gem 'fullcalendar-rails', '~> 2.4'
gem 'momentjs-rails', '~> 2.10'
gem 'yard'
gem 'gimei'
gem 'whenever', :require => false
gem 'resque'
gem 'resque-scheduler'
gem 'gon'
gem 'activeadmin', github: 'activeadmin'
gem 'underscore-rails'
gem 'enum_help'

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'factory_bot_rails'
gem 'faker'

gem 'therubyracer', platforms: :ruby
group :development do
  gem 'web-console'
  gem 'letter_opener'
end

group :development, :test do
  gem 'byebug'
  gem 'spring'
  gem "spring-commands-rspec"
  gem 'guard'
  gem 'terminal-notifier-guard'
  gem 'rspec-rails'
  gem 'database_rewinder'
  gem 'rspec-power_assert'
  gem 'rspec-parameterized'
  gem "shoulda-matchers", '2.8.0'
  gem 'timecop'
  gem 'guard-rspec', require: false
  gem 'rubocop'
  gem 'guard-rubocop'
  gem 'guard-livereload', require: false
  gem "rails-erd"
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'rails_best_practices'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'awesome_print'
  gem 'hirb'
  gem 'hirb-unicode'
  gem "view_source_map"
  gem 'rack-mini-profiler', require: false
end

group :production, :staging, :review_app do
  gem 'rails_12factor'
  gem "memcachier"
  gem 'dalli'
  gem 'rack-cache'
  gem 'kgio'
end

group :review_app do
  gem 'letter_opener'
  gem 'letter_opener_web'
end
