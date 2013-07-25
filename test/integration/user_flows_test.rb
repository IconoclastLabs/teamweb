require 'test_helper'
 
class UserFlowsTest < ActionDispatch::IntegrationTest
  test "login page loads" do
    get "/users/sign_up"
    assert_response :success
  end
end