require 'test_helper'
require 'minitest/pride'

class EventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @event = events(:event_one)
  end

  test "should get index" do
    get :index, coordinator_id: @event.coordinator_id
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new, coordinator_id: @event.coordinator_id
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, coordinator_id: @event.coordinator_id, event: { about: @event.about, end: @event.end, location: @event.location, name: @event.name, start: @event.start }
    end

    assert_redirected_to coordinator_event_path(@event.coordinator, assigns(:event))
  end

  test "should show event" do
    get :show, id: @event, coordinator_id: @event.coordinator_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event, coordinator_id: @event.coordinator_id
    assert_response :success
  end

  test "should update event" do
    put :update, coordinator_id: @event.coordinator_id, id: @event, event: { about: @event.about, end: @event.end, location: @event.location, name: @event.name, start: @event.start }
    assert_redirected_to coordinator_event_path(@event.coordinator, assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event, coordinator_id: @event.coordinator_id
    end

    assert_redirected_to events_path
  end
end
