require 'test_helper'

class SeasonsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @season = seasons(:season_one)
  end

  test "should get index" do
    get :index, organization_id: @season.organization_id
    assert_response :success
    assert_not_nil assigns(:seasons)
  end

  test "requires login to get new" do
    get :new, organization_id: @season.organization_id
    assert_response :redirect #302
  end

  test "should get new" do
    sign_in User.first
    get :new, organization_id: @season.organization_id
    assert_response :success
  end

  test "requires login to create season" do
    assert_no_difference('Season.count') do
      post :create, organization_id: @season.organization_id, season: { end: @season.end, max_members: @season.max_members, max_team_size: @season.max_team_size, max_teams: @season.max_teams, members_allowed: @season.members_allowed, name: @season.name, start: @season.start, teams_allowed: @season.teams_allowed }
    end
  end

  test "should create season" do
    sign_in User.first
    assert_difference('Season.count') do
      post :create, organization_id: @season.organization_id, season: { end: @season.end, max_members: @season.max_members, max_team_size: @season.max_team_size, max_teams: @season.max_teams, members_allowed: @season.members_allowed, name: @season.name + "different", start: @season.start, teams_allowed: @season.teams_allowed }
    end

    new_season = assigns(:season)
    assert_redirected_to organization_season_path(new_season.organization, new_season)
  end

  test "should show season" do
    get :show, organization_id: @season.organization_id, id: @season
    assert_response :success
  end

  test "requires login to edit" do
    get :edit, organization_id: @season.organization_id, id: @season
    assert_response :redirect #302
  end

  test "should get edit" do
    sign_in User.first
    get :edit, organization_id: @season.organization_id, id: @season
    assert_response :success
  end

  test "requires login to update season" do
    patch :update, organization_id: @season.organization_id, id: @season, season: { end: @season.end, max_members: @season.max_members, max_team_size: @season.max_team_size, max_teams: @season.max_teams, members_allowed: @season.members_allowed, name: @season.name, start: @season.start, teams_allowed: @season.teams_allowed }
    assert_response :redirect #302
  end

  test "should update season" do
    sign_in User.first
    patch :update, organization_id: @season.organization_id, id: @season, season: { end: @season.end, max_members: @season.max_members, max_team_size: @season.max_team_size, max_teams: @season.max_teams, members_allowed: @season.members_allowed, name: @season.name, start: @season.start, teams_allowed: @season.teams_allowed }
    new_season = assigns(:season)
    assert_redirected_to organization_season_path(@season.organization, new_season)
  end


  test "should destroy season" do
    assert_no_difference('Season.count') do
      delete :destroy, organization_id: @season.organization_id, id: @season
    end
  end

  test "should destroy season" do
    sign_in User.first
    assert_difference('Season.count', -1) do
      delete :destroy, organization_id: @season.organization_id, id: @season
    end

    assert_redirected_to organization_seasons_path
  end
end
