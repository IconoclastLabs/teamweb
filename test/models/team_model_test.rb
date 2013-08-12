require 'test_helper'

class TeamModelTest < ActiveSupport::TestCase
  before { 
    @no_teams_event = events(:event_four)
  }

  let(:simple_team) {Team.new(name: 'TestName', max_members: 5)}  

  test "Teams are invalid on Events that disallow teams" do
    @no_teams_event.teams_allowed?.must_equal false
    simple_team.event = @no_teams_event
    simple_team.valid?.must_equal false
  end
end
