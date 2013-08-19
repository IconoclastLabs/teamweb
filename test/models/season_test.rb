require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  let(:simple_season) {Season.new(name: 'TestName')}

  before { 
    @organization_one = seasons(:coord_one)
    @organization_two = seasons(:coord_two)
    @season_one = seasons(:season_one)
    @first_user = Users.first
  }

  it 'can create a new Season' do
    simple_season.valid?.must_equal true
  end

  it 'requires a name' do
    simple_season.name = nil
    simple_season.valid?.must_equal false
  end  

  it 'should be unique per organization id' do
    simple_season.organization = @organization_one
    simple_season.save.must_equal true
    # try to save again with exact same info
    new_season = simple_season.clone
    new_season.id = nil
    new_season.valid?.must_equal false
    # change organization id and all is fixed!
    new_season.organization = @organization_two
    new_season.valid?.must_equal true
  end  

  it 'can have events' do
    assert_respond_to(simple_season, :events)
  end

  it 'can have teams' do
    assert_respond_to(simple_season, :teams)
  end

  it 'can have users' do
    assert_respond_to(simple_season, :users)
  end

  it 'adds a member' do
    season_two = seasons(:season_two)
    season_two.users.reload
    season_two.users.include?(@first_user).must_equal false
    season_two.add_event_member(@first_user).must_equal true
    season_two.users.reload
    season_two.users.include?(@first_user).must_equal true
  end

  it 'must at least have room for one member if members are allowed' do
    simple_season.max_members = 1
    simple_season.members_allowed = true
    simple_season.valid?.must_equal true
    simple_season.max_members = 0
    simple_season.valid?.must_equal false
  end

  it 'cannot exceed max_members' do
    simple_season.max_members = 1
    simple_season.save.must_equal true
    simple_season.add_event_member(users(:one)).must_equal true
    simple_season.add_event_member(users(:two)).wont_equal true
    simple_season.members.size.must_equal 1
  end

  it 'is idempotent with saving the same event member' do
    assert_no_difference('@season_one.members.size') do
      success = @season_one.add_event_member(@first_user, admin_flag: false)
      success.must_equal true
    end
  end

  it 'must at least have room for one team member if it is set' do
    simple_season.max_team_size = 0 
    simple_season.valid?.must_equal false
  end

  it 'must at least have room for one team if teams are allowed' do
    simple_season.max_teams = 1
    simple_season.teams_allowed = true
    simple_season.valid?.must_equal true
    simple_season.max_teams = 0
    simple_season.valid?.must_equal false
  end  


end
