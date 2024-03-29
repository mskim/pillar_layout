# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0', '>= 6.0.1'
# Use sqlite3 as the database for Active Record
# Use ActiveStorage variant
gem 'bootsnap', require: false
gem 'mini_magick', '~> 4.8'
# gem 'pg', '~> 0.20'
gem 'pg'
# gem 'sqlite3'
# Use Puma as the app server
# gem 'puma', '~> 3.11'
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# gem 'redis-rails', '~> 5.0', '>= 5.0.2'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'minitest-spec-rails'
  gem 'pry-byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'griddler'

# gem 'high_voltage'
# gem 'jquery-ace-rails'
# gem 'will_paginate'
# gem 'will_paginate-bootstrap4'
# gem 'bootstrap-sass'
gem 'administrate'
gem 'administrate-field-active_storage'
# gem 'bootstrap', '~> 4.4', '>= 4.4.1'
gem 'bootstrap', '~> 4.6'
# paginate
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'bootstrap4-kaminari-views'
gem 'pagy'
gem 'i18n'

gem 'bootstrap_form'
gem 'browser'
gem 'carrierwave'
gem 'devise'
gem 'devise-i18n'
gem 'faker'
# gem 'hexapdf', '=0.11.4'
gem 'hexapdf', '=0.11.5'
gem 'rails_layout'
gem 'ransack'
# gem 'rest-client'
gem 'rubypants-unicode'
gem 'seed_dump'
gem 'simple_form', '~> 4.0.1'
# gem 'sinatra', '~> 2.0.1'
gem 'webpacker'
gem 'whenever'

gem 'bootstrap3-datetimepicker-rails', '~> 4.14.30'
# gem 'mechanize'
gem 'momentjs-rails', '>= 2.9.0'
gem 'rubyzip', '>= 1.0.0'
gem 'zip-zip'
# gem 'pgreset', '~> 0.1.1'
gem 'friendly_id', '~> 5.2', '>= 5.2.4'
# gem 'simplecov', require: false, group: :test

group :development, :test do
  # gem 'database_cleaner', '~> 1.7'
  # gem 'rspec-rails', '~> 3.8'
  # gem 'shoulda-matchers', '~> 3.1', '>= 3.1.2', require: false
  # gem 'chromedriver-helper'
  # gem 'factory_bot_rails'
  # gem 'launchy'
  # gem 'rails-controller-testing'
  gem 'webdrivers'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

# gem 'bullet', group: 'development'
# gem 'rack-cors', require: 'rack/cors'

# gem 'ajax-datatables-rails'
gem 'jquery-datatables'
gem 'rails-assets-trix', source: 'https://rails-assets.org'

gem 'ancestry'
# gem 'happymapper'
gem 'nokogiri-happymapper', '~> 0.8.1'
gem 'rails-assets-jcrop', source: 'https://rails-assets.org'
gem 'stateful_enum'
# gem 'sucker_punch'

gem 'guard'
gem 'guard-rake'
gem 'guard-remote-sync', '~> 0.1.0'
gem 'guard-shell'

gem 'image_processing', '~> 1.2'
gem 'simple_calendar', '~> 2.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-chosen'
  gem 'rails-assets-chosen-bootstrap'
end
gem 'annotate'
gem 'rlayout', path: "/Users/#{ENV['USER']}/Development/ruby/gems/rlayout"

gem 'font-awesome-sass'
gem 'rubyXL'
gem 'acts_as_tenant'
gem 'kramdown'
gem 'sidekiq', '~> 6.1', '>= 6.1.3'
gem 'sucker_punch', '~> 2.1', '>= 2.1.2'
# gem "standard", group: [:development, :test]
gem 'text-hyphen', '~> 1.4'
