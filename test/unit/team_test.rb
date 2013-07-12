# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rank       :decimal(, )
#

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  before { 
    @team_one = teams(:team_one) 
    @event_one = events(:event_one)
    @event_two = events(:event_two)
  }
  let(:simple_team) {Team.new(name: 'TestName')}
  it 'can create a new Team' do
    simple_team.valid?.must_equal true
  end

  it 'requires a name' do
    simple_team.name = nil
    simple_team.valid?.must_equal false
  end

  it 'should be unique per event id' do
    simple_team.event = @event_one
    simple_team.save.must_equal true
    # try to save again with exact same info
    new_team = simple_team.clone
    new_team.id = nil
    new_team.valid?.must_equal false
    # change event id and all is fixed!
    new_team.event = @event_two
    new_team.valid?.must_equal true
  end
end
