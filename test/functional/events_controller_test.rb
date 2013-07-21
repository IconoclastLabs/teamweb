require 'test_helper'
require 'minitest/pride'

class EventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @event = events(:event_one)
    
    @new_event = events(:event_two) 
    @new_event.id = nil
    @new_event.name = "Different"
  end

  test "get list" do
    get :list
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "get index" do
    get :index, organization_id: @event.organization_id
    assert_response :success
    assert_not_nil assigns(:events)
  end
  
  test "certain index buttons require login" do
    get :index, organization_id: @event.organization_id
    assert_select "a", {count: 0, text: "New Event"}, "Shouldn't have a new button"
    assert_select "a", {count: 0, text: "Edit"}, "Shouldn't have an edit button"
    assert_select "a", {count: 0, text: "Delete"}, "Shouldn't have a delete button"
  end

  test "certain index buttons show with login" do
    sign_in User.first
    get :index, organization_id: @event.organization_id
    assert_select "a", "New Event", "Should have a new button"
    assert_select "a", "Edit", "Should have an edit button"
    assert_select "a", "Delete", "Should have a delete button"
  end

  test "require login to get new" do
    get :new, organization_id: @event.organization_id
    assert_response :redirect #302
  end

  test "get new" do
    sign_in User.first
    get :new, organization_id: @event.organization_id
    assert_response :success
  end  

  test "require login to create event" do
    assert_no_difference('Event.count') do
      post :create, organization_id: @new_event.organization_id, event: { about: @new_event.about, end: @new_event.end, location: @new_event.location, name: @new_event.name, start: @new_event.start}
    end
  end

  test "create event" do
    sign_in User.first
    assert_difference('Event.count') do
      post :create, organization_id: @event.organization_id, event: { about: @new_event.about, end: @new_event.end, location: @new_event.location, name: @new_event.name, start: @new_event.start}
    end

    assert_redirected_to organization_event_path(@event.organization, assigns(:event))
  end

  test "show event" do
    get :show, id: @event, organization_id: @event.organization_id
    assert_response :success
    assert_not_nil assigns(:event)
    assert_not_nil assigns(:organization)
  end

  test "require login to get edit" do
    get :edit, id: @event, organization_id: @event.organization_id
    assert_response :redirect #302
  end

  test "get edit" do
    sign_in User.first
    get :edit, id: @event, organization_id: @event.organization_id
    assert_response :success
  end

  test "require login to update event" do
    put :update, organization_id: @event.organization_id, id: @event, event: { about: @event.about, end: @event.end, location: @event.location, name: @event.name, start: @event.start }
    assert_redirected_to user_session_path
  end

  test "update event" do
    sign_in User.first
    put :update, organization_id: @event.organization_id, id: @event, event: { about: @event.about, end: @event.end, location: @event.location, name: @event.name, start: @event.start }
    assert_redirected_to organization_event_path(@event.organization, assigns(:event))
  end

  test "require login to destroy event" do
    assert_no_difference('Event.count') do
      delete :destroy, id: @event, organization_id: @event.organization_id
    end
  end

  test "destroy event" do
    sign_in User.first
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event, organization_id: @event.organization_id
    end

    assert_redirected_to organization_events_path(@event.organization)
  end
end
