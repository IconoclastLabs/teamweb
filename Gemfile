source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'bourbon'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby
gem 'uglifier', '>= 1.3.0'
gem 'compass'

gem 'execjs'
gem 'jquery-rails'
gem "haml-rails"
gem "bootstrap-sass", ">= 2.3.0.0"

gem "rails-boilerplate"

# To use Jbuilder templates for JSON
gem 'jbuilder'

gem "devise", '~> 3.1.0.rc2'
gem 'puma'

# rails 4
gem "simple_form", "~> 3.0.0.rc"

gem "stamp"
gem "gmaps4rails"
gem "figaro"
gem 'friendly_id', github: 'FriendlyId/friendly_id', branch: 'master' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

# sample data stuff
gem 'populator'
gem 'forgery'
gem "literate_randomizer"

#Performance Inspection Gems
gem 'rails_javascript_log' # allows browser independent logging for js with styles `log('what *is* this?')`
gem 'peek' # awesome magic- https://github.com/peek/peek
gem 'peek-git'
gem 'peek-performance_bar'
gem 'peek-gc'
gem 'peek-rblineprof'
gem 'pygments.rb', :require => false


gem 'kaminari' #allows for pagination

# OmniAuth stuff
gem 'omniauth'
gem 'omniauth-facebook'

# Production for Heroku
group :production do
  gem 'pg'
  gem 'dalli'
end


group :test do
  gem 'simplecov', :require => false
  gem 'turn' # colored minitests
  gem 'sqlite3'
  gem 'awesome_print' # OF COURSE!
  gem 'minitest-spec-rails'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'pry-debugger'
  gem 'pry-doc'
  gem 'interactive_editor' # able to vi from irb
  #gem "parallel_tests"
  # BDD
  gem 'capybara'
  gem 'capybara_minitest_spec' # for capybara integration and spec matchers
  gem 'poltergeist' # for headless javascript testing. See Phantomjs.org for installation details
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
  

  gem "better_errors"
  gem "binding_of_caller" # required for better_errors
  
end

group :development do
  gem 'rake'
  gem 'sqlite3'
	gem 'awesome_print' # OF COURSE!
  gem 'minitest-spec-rails'
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
  gem 'pry-debugger'
  gem 'pry-doc'
  gem 'interactive_editor' # able to vi from irb
  gem "quiet_assets", ">= 1.0.1"
  gem 'guard'
  gem 'guard-rails'
  gem 'guard-minitest'
  gem 'guard-annotate'
  gem 'guard-puma'
  gem 'guard-bundler', "~> 1.0.0"
  gem 'brakeman' # checks for security vulns
  gem 'guard-brakeman'
  #gem 'guard-test'
  gem "better_errors"
  gem "binding_of_caller" # required for better_errors
  gem 'annotate'
  #gem "literate_randomizer"
  # Filesystem notifiers, mostly for guard
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  
  # Additions suggested by article 
  # http://www.codebeerstartups.com/2013/04/must-have-gems-for-development-machine-in-ruby-on-rails/
  gem 'bullet'
  gem 'localtunnel', :require => false #exposes site as needed ($ localtunnel-beta 8000)
  # gem 'mailcatcher' opting for letter_opener instead
  gem "letter_opener"
  gem 'lol_dba' # site optimization? ($ rake db:find_indexes > $ )
  gem 'reek' # check for code smells ($ reek -q .)
  gem 'rails_best_practices', :require => false # check for best practice fixes ($ rails_best_practices .)
  gem 'request-log-analyzer', :require => false # check out the live website request logs for performance issues/info 
  #                         ($ request-log-analyzer --parse-strategy assume-correct log/development.log)
  gem 'smusher', :require => false # optimize images ($ smusher app/assets/images)

end

