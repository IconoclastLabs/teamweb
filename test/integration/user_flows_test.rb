require 'test_helper'
require 'capybara/rails'

# I'm mixing capybara in some tests, but not all.  Each test must be all one or the other, they cannot mix inside each test.
class UserFlowsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    @user = User.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
  end

  # using capybara
  test "front page has a login button" do
    visit root_path
    click_link_or_button('Login')
    assert_equal page.current_path, user_session_path
  end

  test "sign_up page loads" do
    get new_user_registration_path
    assert_response :success
  end

  test "you can login" do
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
    assert_equal root_path, path
    assert_equal 'Signed in successfully.', flash[:notice]
  end

  # using capybara
  test "edit user page" do
    capybara_sign_in(@user)
    click_link_or_button('Account')
    click_link_or_button('Profile')
    assert_equal page.current_path, edit_user_registration_path
    assert page.has_content?('DANGER ZONE!!!')
  end

  # using capybara
  test "Facebook Login" do
    skip "fix this later"
    capybara_facebook_sign_in

    assert_equal page.current_path, "/users/auth/facebook/callback"
  end

end