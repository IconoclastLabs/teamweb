require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @organization = organizations(:coord_one)
  end

  test "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizations)
  end

  test "certain index buttons require login" do
    get :index
    assert_select "a", {count: 0, text: "New Organization"}, "Shouldn't have a new button"
    assert_select "a", {count: 0, text: "Edit"}, "Shouldn't have an edit button"
    assert_select "a", {count: 0, text: "Delete"}, "Shouldn't have a delete button"
  end

  test "certain index buttons show with login" do
    sign_in User.first
    get :index
    assert_select "a", "New Organization", "Should have a new button"
    assert_select "a", "Edit", "Should have an edit button"
    assert_select "a", "Delete", "Should have a delete button"
  end

  test "require login to get new" do
    get :new
    assert_response :redirect #302
  end

  test "get new" do
    sign_in User.first
    get :new
    assert_response :success
  end

  test "require login to create organization" do
    assert_no_difference('Organization.count') do
      post :create, organization: { about: @organization.about, contact: @organization.contact, location: @organization.location, name: @organization.name }
    end
  end

  test "create organization when logged in" do
    sign_in User.first
    assert_difference('Organization.count') do
      post :create, organization: { about: @organization.about, contact: @organization.contact, location: @organization.location, name: @organization.name }
    end

    new_org = assigns(:organization)
    # should have the user that created it
    new_org.members.admins.size.wont_equal 0
    assert_redirected_to organization_path(new_org)
    
  end

  test "show organization" do
    get :show, id: @organization
    assert_response :success
  end

  test "require login to get edit" do
    get :edit, id: @organization
    assert_response :redirect #302
  end

  test "get edit" do
    sign_in User.first
    get :edit, id: @organization
    assert_response :success
  end

  test "require login to update organization" do
    put :update, id: @organization, organization: { about: @organization.about, contact: @organization.contact, location: @organization.location, name: @organization.name }
    assert_redirected_to user_session_path
  end

  test "update organization" do
    sign_in User.first
    put :update, id: @organization, organization: { about: @organization.about, contact: @organization.contact, location: @organization.location, name: @organization.name }
    assert_redirected_to organization_path(assigns(:organization))
  end

  test "require login to destroy organization" do
    assert_no_difference('Organization.count') do
      delete :destroy, id: @organization
    end
  end

  test "destroy organization" do
    sign_in User.first
    assert_difference('Organization.count', -1) do
      delete :destroy, id: @organization
    end

    assert_redirected_to organizations_path
  end
end
