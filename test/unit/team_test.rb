require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  let(:simple_team) {Team.new(name: 'TestName')}
  it 'can create a new Team' do
    simple_team.valid?.must_equal true
  end

  it 'requires a name' do
    simple_team.name = nil
    simple_team.valid?.must_equal false
  end
end
