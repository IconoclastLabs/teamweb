require 'test_helper'

class Api::V1::OrganizationControllerTest < ActionController::TestCase
  #include Devise::TestHelpers

  #setup do
  #  @organization = organizations(:coord_one)
  #end

  test "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizations)
  end

end
