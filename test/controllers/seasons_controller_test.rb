require 'test_helper'

class SeasonsControllerTest < ActionController::TestCase
  setup do
    @season = seasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create season" do
    assert_difference('Season.count') do
      post :create, season: { end: @season.end, max_members: @season.max_members, max_team_size: @season.max_team_size, max_teams: @season.max_teams, members_allowed: @season.members_allowed, name: @season.name, start: @season.start, teams_allowed: @season.teams_allowed }
    end

    assert_redirected_to season_path(assigns(:season))
  end

  test "should show season" do
    get :show, id: @season
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @season
    assert_response :success
  end

  test "should update season" do
    patch :update, id: @season, season: { end: @season.end, max_members: @season.max_members, max_team_size: @season.max_team_size, max_teams: @season.max_teams, members_allowed: @season.members_allowed, name: @season.name, start: @season.start, teams_allowed: @season.teams_allowed }
    assert_redirected_to season_path(assigns(:season))
  end

  test "should destroy season" do
    assert_difference('Season.count', -1) do
      delete :destroy, id: @season
    end

    assert_redirected_to seasons_path
  end
end
