require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
    
  setup do
    @team = teams(:team_one)

    @new_team = teams(:team_two) 
    @new_team.id = nil
    @new_team.name = "Different"
  end

  test "get index" do
    get :index, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  test "certain index buttons require login" do
    get :index, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_select "a", {count: 0, text: "New Team"}, "Shouldn't have a new button"
    assert_select "a", {count: 0, text: "Edit"}, "Shouldn't have an edit button"
    assert_select "a", {count: 0, text: "Delete"}, "Shouldn't have a delete button"
  end

  test "certain index buttons show with login" do
    sign_in User.first
    get :index, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_select "a", "New Team", "Should have a new button"
    assert_select "a", "Edit", "Should have an edit button"
    assert_select "a", "Delete", "Should have a delete button"
  end

  test "require login to get new" do
    get :new, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_response :redirect #302
  end

  test "should get new" do
    sign_in User.first
    get :new, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:team)
  end

  test "require login to create team" do
    assert_no_difference('Team.count') do
      post :create, organization_id: @new_team.event.organization_id, event_id: @new_team.event_id, team: { name: @new_team.name }
    end
  end

  test "create team" do
    sign_in User.first
    assert_difference('Team.count') do
      post :create, organization_id: @team.event.organization_id, event_id: @team.event_id, team: { name: @new_team.name }
    end

    assert_redirected_to organization_event_team_path(@team.event.organization, @team.event, assigns(:team))
  end

  test "show team" do
    get :show, id: @team, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:team)
  end

  test "require login to get edit" do
    get :edit, id: @team, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_response :redirect #302
  end

  test "get edit" do
    sign_in User.first
    get :edit, id: @team, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_response :success
    assert_not_nil assigns(:team)
  end

  test "require login to update team" do
    put :update, id: @team, team: { name: @team.name }, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_redirected_to user_session_path
  end

  test "update team" do
    sign_in User.first
    put :update, id: @team, team: { name: @team.name }, organization_id: @team.event.organization_id, event_id: @team.event_id
    assert_redirected_to organization_event_team_path(organization_id: @team.event.organization_id, event_id: @team.event_id)
  end

  test "require login to destroy team" do
    assert_no_difference('Team.count') do
      delete :destroy, id: @team, organization_id: @team.event.organization_id, event_id: @team.event_id
    end
  end

  test "destroy team" do
    sign_in User.first
    assert_difference('Team.count', -1) do
      delete :destroy, id: @team, organization_id: @team.event.organization_id, event_id: @team.event_id
    end
    assert_redirected_to organization_event_teams_path(@team.event.organization, @team.event)
    assert_not_nil assigns(:team)
  end
end
