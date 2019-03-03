# 3/3/19 I had a problem where wol dnot intially push to heroku because of wrong bundler versin I think.
# Heroku has its own bundler version which must be compatible. I did gem install bunder version 2.0.1
# and then had to change the gemlock file to BUNDLED WITH 2.0.1 instead of 2.0.0 at the bottom of the
# file and that worked. Don't know if I will ahve to manually install the correct version of bundler
# now, or perhaps I could add bundler 2.0.1 to the file to specify this

source 'https://rubygems.org'

gem 'rails',        '5.1.6'
gem 'bcrypt',       '3.1.12'
gem 'bootstrap-sass', '3.3.7'
gem 'puma',         '3.9.1'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest',                 '5.10.3'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

group :production do
  gem 'pg', '0.20.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
