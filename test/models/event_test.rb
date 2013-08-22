# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  about           :string(255)
#  organization_id :integer
#  location        :string(255)
#  start           :date
#  end             :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  latitude        :float
#  longitude       :float
#  gmaps           :boolean
#  max_members     :integer
#  members_allowed :boolean          default(TRUE)
#  teams_allowed   :boolean          default(TRUE)
#  max_teams       :integer
#  max_team_size   :integer
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
	before { 
		@event_one = events(:event_one)
    @first_user = @event_one.users.first
    @season_one = seasons(:season_one)
    @season_two = seasons(:season_two)
	}

  let(:simple_event) {Event.new(name: 'TestName', about: 'TestAbout', location: 'New Orleans', start: '2013-05-31', end: '2013-05-31', latitude: nil, longitude: nil, gmaps: true)}
  
  it 'can create a new Event' do
    simple_event.valid?.must_equal true
  end

  it 'requires a name' do
    simple_event.name = nil
    simple_event.valid?.must_equal false
  end

  it 'should be unique per season id' do
  	simple_event.season = @season_one
  	simple_event.save.must_equal true
  	# try to save again with exact same info
  	new_event = simple_event.clone
  	new_event.id = nil
  	new_event.valid?.must_equal false
  	# change organization id and all is fixed!
  	new_event.season = @season_two
  	new_event.valid?.must_equal true
  end

  it 'has a season' do
    # verify the property exists
    assert_respond_to(@event_one, :season)
    # verify it is set
    assert_not_nil @event_one.season
  end

  it 'can have teams' do
    assert_respond_to(@event_one, :teams)
  end

  it 'can have users' do
    assert_respond_to(@event_one, :users)
  end

  it 'can add an event member' do
    event_two = events(:event_two)
    event_two.users.reload
    event_two.users.include?(@first_user).must_equal false
    event_two.add_member(@first_user).must_equal true
    event_two.users.reload
    event_two.users.include?(@first_user).must_equal true
  end

  it 'is idempotent with saving the same event member' do
    assert_no_difference('@event_one.members.size') do
      success = @event_one.add_member(@first_user, admin_flag: false)
      success.must_equal true
    end
  end
end
