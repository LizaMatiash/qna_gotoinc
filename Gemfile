source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'slim-rails'

gem 'devise'

gem 'jquery-rails'

gem 'carrierwave'
gem 'cocoon'

gem 'gon'
gem 'handlebars_assets'

gem 'responders'

# l10
gem 'capybara-email'
gem 'omniauth', '~> 1.9.1'
gem 'omniauth-github', '~> 1.4.0'
gem 'omniauth-twitter'

# l11
gem 'cancancan'


# l12
gem 'doorkeeper', '~> 4.2.6'

# l13
gem 'active_model_serializers'
gem 'oj'
gem 'oj_mimic_json'

# l14
# gem 'delayed_job_active_record'
gem 'sidekiq', '~> 4.2.9'
gem 'whenever', '0.7.0', :require => false

# l15
gem 'mysql2', '~> 0.4.10'
gem "thinking-sphinx",
  :git    => "https://github.com/pat/thinking-sphinx.git",
  :branch => "develop",
  :ref    => "d1e3603c9e"

# l20
gem 'dotenv'
gem 'dotenv-deployment', require: 'dotenv/deployment'
gem 'therubyracer'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rexml'
  gem 'database_cleaner'
  # gem 'capybara-webkit'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'letter_opener'

  # l20
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver', '>= 4.0.0.rc1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'shoulda-matchers'
  gem 'launchy'
  gem 'json_spec'
  gem 'rspec-its'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
