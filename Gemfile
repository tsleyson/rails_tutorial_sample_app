source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '4.0.2'
gem 'bootstrap-sass'  # Fancier CSS with nesting and variables

#gem 'bcrypt', '~> 3.0.0'
# Using a newer version causes some conflict with Heroku, so let it
# use whatever version it wants.
gem 'bcrypt-ruby', '>= 3.0.0'  # cryptographic hashing
gem 'protected_attributes'
gem 'faker' # make fake users
gem 'will_paginate'
gem 'bootstrap-will_paginate'

#gem 'strong_parameters', '>= 0.2.0' Built in to Rails 4.

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '>= 4.2.1' # database mock object factory
  gem 'launchy'  # permits use of Capybara's save_and_open_page
end


# Gems used only for assets and not required
# in production environments by default (because the
# assets compile to native Javascript or CSS).
group :assets do
  gem 'sass-rails',   '>= 3.2.3'
  gem 'coffee-rails', '>= 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end
