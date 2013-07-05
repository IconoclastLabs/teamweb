require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
    
  setup do
    @team = teams(:one)
  end

  test "should get index" do
    get :index, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "should get new" do
    get :new, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :success
  end

  test "should create team" do
    assert_difference('Team.count') do
      post :create, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id, @team: { name: @team.name }
    end

    assert_redirected_to team_path(coordinator_id: @team.event.coordinator_id, event_id: @team.event_id, assigns(:team))
  end

  test "should show team" do
    get :show, id: @team, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @team, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :success
  end

  test "should update team" do
    put :update, id: @team, team: { name: @team.name }, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_redirected_to team_path(coordinator_id: @team.event.coordinator_id, event_id: @team.event_id, assigns(:team))
  end

  test "should destroy team" do
    assert_difference('Team.count', -1) do
      delete :destroy, id: @team, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    end

    assert_redirected_to coordinator_event_teams_path
  end
end
