require 'test_helper'
require 'capybara/rails'

# I'm mixing capybara in some tests, but not all.  Each test must be all one or the other, they cannot mix inside each test.
class UserFlowsTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  setup do
    @user = User.all.where(email: "gant@iconoclastlabs.com").first_or_create(password: "fdsafdsa", name: "Gant Man", phone: "888-888-8888", address: "New Orleans")
  end

  test "front page has a login button" do
    # uses capybara
    visit root_path
    click_link_or_button('Login')
    assert_equal page.current_path, user_session_path
    #assert page.has_content?('Email')
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

  test "edit user page" do
    # using capybara
    capybara_sign_in(@user)
    click_link_or_button('Profile')
    assert_equal page.current_path, edit_user_registration_path
    assert page.has_content?('DANGER ZONE!!!')
  end

  def capybara_sign_in(user)
    visit user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_link_or_button 'Sign in'
    user
  end

end