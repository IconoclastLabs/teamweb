ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

Turn.config do |c|
#  # use one of output formats:
#  # :outline  - turn's original case/test outline mode [default]
#  # :progress - indicates progress with progress bar
#  # :dotted   - test/unit's traditional dot-progress mode
#  # :pretty   - new pretty reporter
#  # :marshal  - dump output as YAML (normal run mode only)
#  # :cue      - interactive testing
  c.format  = :progress
#  # turn on invoke/execute tracing, enable full backtrace
#  c.trace   = true
#  # use humanized test names (works only with :outline format)
  c.natural = true
end

def capybara_sign_in(user)
  visit user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_link_or_button 'Sign in'
  user
end

def capybara_facebook_sign_in
  OmniAuth.config.test_mode = true
  # Doesn't really work yet
  OmniAuth.config.mock_auth[:facebook] = {
    'uid'       => "999999",
    'provider'  => "facebook",
    'extra'     => {
      'user_hash' => {
        'email'   => 'test1@test.com',
        'first_name'  => 'First',
        'last_name'   => 'Last',
        'gender'  => 'Male'
      }
    },
    'credentials' => {
      'token' => "token1234qwert"
    }
  }
  visit user_session_path
  click_link_or_button 'Facebook'
end