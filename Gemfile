# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.4'
# Use pg as the database for Active Record
gem 'pg'
# Use Puma as the app server
# gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'guard-rspec', require: false
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# For User registration
gem 'devise'

# For generate token using JWT
gem 'doorkeeper'
gem 'doorkeeper-jwt'

# For soft delete
gem "paranoia", "~> 2.2"

# For photo and video upload
gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
gem "paperclip-ffmpeg"
gem 'paperclip-av-transcoder'

# RuboCop is a Ruby static code analyzer
gem 'rubocop', require: false

#For serialize model attributes
gem 'active_model_serializers', '~> 0.10.0'

# For pagination
gem 'kaminari'

# Load environment variables from .env into ENV in development
gem 'dotenv-rails'

# For friendly slug
gem 'friendly_id', '~> 5.1.0'

# For Background Job
gem 'delayed_job_active_record'
gem "daemons"

# Cron jobs in Ruby
gem 'whenever', require: false

gem 'paperclip-compression'