require 'test_helper'

class CoordinatorsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @coordinator = coordinators(:coord_one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coordinators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coordinator" do
    assert_difference('Coordinator.count') do
      post :create, coordinator: { about: @coordinator.about, contact: @coordinator.contact, location: @coordinator.location, name: @coordinator.name }
    end

    assert_redirected_to coordinator_path(assigns(:coordinator))
  end

  test "should show coordinator" do
    get :show, id: @coordinator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coordinator
    assert_response :success
  end

  test "should update coordinator" do
    put :update, id: @coordinator, coordinator: { about: @coordinator.about, contact: @coordinator.contact, location: @coordinator.location, name: @coordinator.name }
    assert_redirected_to coordinator_path(assigns(:coordinator))
  end

  test "should destroy coordinator" do
    assert_difference('Coordinator.count', -1) do
      delete :destroy, id: @coordinator
    end

    assert_redirected_to coordinators_path
  end
end
