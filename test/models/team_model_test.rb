require 'test_helper'

class TeamModelTest < ActiveSupport::TestCase
  before { 
    @season_one = seasons(:season_one)
    @no_teams_season = seasons(:season_three)
  }

  let(:simple_team) {Team.new(name: 'TestName', max_members: 5)}  

  test 'cannot exceed max_members' do
    simple_team.max_members = 1
    simple_team.save.must_equal true
    simple_team.add_team_member(users(:one)).must_equal true
    simple_team.add_team_member(users(:two)).wont_equal true
    simple_team.members.size.must_equal 1
  end
  
  test "Teams are invalid on Seasons that disallow teams" do
    @no_teams_season.teams_allowed?.must_equal false
    simple_team.season = @no_teams_season
    simple_team.valid?.must_equal false
  end

  it 'Max Members can never be set greater than Event Max Team Size' do
    simple_team.season = @season_one
    @season_one.max_team_size = 5
    simple_team.max_members = 5
    simple_team.valid?.must_equal true
    simple_team.max_members = 6
    simple_team.valid?.must_equal false
  end

  it 'cannot exceed max_members' do
    simple_team.max_members = 1
    simple_team.save.must_equal true
    simple_team.add_team_member(users(:one)).must_equal true
    simple_team.add_team_member(users(:two)).wont_equal true
    simple_team.members.size.must_equal 1
  end

end
