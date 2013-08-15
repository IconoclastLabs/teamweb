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
		@coord_one = organizations(:coord_one)
		@coord_two = organizations(:coord_two)
	}

  let(:simple_event) {Event.new(name: 'TestName', about: 'TestAbout', location: 'New Orleans', start: '2013-05-31', end: '2013-05-31', latitude: nil, longitude: nil, gmaps: true)}
  it 'can create a new Event' do
    simple_event.valid?.must_equal true
  end

  it 'requires a name' do
    simple_event.name = nil
    simple_event.valid?.must_equal false
  end

  it 'should be unique per organization id' do
  	simple_event.organization = @coord_one
  	simple_event.save.must_equal true
  	# try to save again with exact same info
  	new_event = simple_event.clone
  	new_event.id = nil
  	new_event.valid?.must_equal false
  	# change organization id and all is fixed!
  	new_event.organization = @coord_two
  	new_event.valid?.must_equal true
  end

  it 'has an organization' do
    # verify the property exists
    assert_respond_to(@event_one, :organization)
    # verify it is set
    assert_not_nil @event_one.organization
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
    event_two.add_event_member(@first_user).must_equal true
    event_two.users.reload
    event_two.users.include?(@first_user).must_equal true
  end

  it 'cannot exceed max_members' do
    simple_event.max_members = 1
    simple_event.save.must_equal true
    simple_event.add_event_member(users(:one)).must_equal true
    simple_event.add_event_member(users(:two)).wont_equal true
    simple_event.members.size.must_equal 1
  end

  it 'is idempotent with saving the same event member' do
    assert_no_difference('@event_one.members.size') do
      success = @event_one.add_event_member(@first_user, admin_flag: false)
      success.must_equal true
    end
  end

  it 'must at least have room for one team member if it is set' do
    simple_event.max_team_size = 0 
    simple_event.valid?.must_equal false
  end

  it 'must at least have room for one team if teams are allowed' do
    simple_event.max_teams = 0
    simple_event.teams_allowed = true
    binding.pry
    simple_event.valid?.must_equal false
  end
end
