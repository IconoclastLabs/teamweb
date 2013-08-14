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

  test "create team button won't show if parent disallows teams" do
    sign_in User.first
    no_teams_event = events(:event_four)
    assert no_teams_event.teams_allowed == false #no teams
    get :index, organization_id: no_teams_event.organization_id, event_id: no_teams_event.id
    assert_select "a", {count: 0, text: "New Team"}, "Shouldn't have a new button"
  end

  test "create team button shows if parent allows teams" do
    sign_in User.first
    teams_event = events(:event_two)
    assert teams_event.teams_allowed # check fixture
    get :index, organization_id: teams_event.organization_id, event_id: teams_event.id
    assert_select "a", "New Team", "Should have a new button"
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

    new_team = assigns(:team)
    # should have the user that created it
    new_team.members.admins.size.wont_equal 0
    assert_redirected_to organization_event_team_path(new_team.event.organization, new_team.event, new_team)
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
