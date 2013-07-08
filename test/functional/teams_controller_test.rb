require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
    
  setup do
    @team = teams(:one)
  end

  test "get index" do
    get :index, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "require login to get new" do
    get :new, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :redirect #302
  end

  test "should get new" do
    sign_in User.first
    get :new, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:team)
  end

  test "require login to create team" do
    assert_no_difference('Team.count') do
      post :create, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id, team: { name: @team.name }
    end
  end

  test "create team" do
    sign_in User.first
    assert_difference('Team.count') do
      post :create, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id, team: { name: @team.name }
    end

    assert_redirected_to coordinator_event_team_path(@team.event.coordinator, @team.event, assigns(:team))
  end

  test "show team" do
    get :show, id: @team, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:team)
  end

  test "require login to get edit" do
    get :edit, id: @team, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :redirect #302
  end

  test "get edit" do
    sign_in User.first
    get :edit, id: @team, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:team)
  end

  test "require login to update team" do
    put :update, id: @team, team: { name: @team.name }, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_redirected_to user_session_path
  end

  test "update team" do
    sign_in User.first
    put :update, id: @team, team: { name: @team.name }, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    assert_redirected_to coordinator_event_team_path(coordinator_id: @team.event.coordinator_id, event_id: @team.event_id)
  end

  test "require login to destroy team" do
    assert_no_difference('Team.count') do
      delete :destroy, id: @team, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    end
  end

  test "destroy team" do
    sign_in User.first
    assert_difference('Team.count', -1) do
      delete :destroy, id: @team, coordinator_id: @team.event.coordinator_id, event_id: @team.event_id
    end
    assert_redirected_to coordinator_event_teams_path(@team.event.coordinator, @team.event)
    assert_not_nil assigns(:team)
  end
end
