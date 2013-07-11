# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  about          :string(255)
#  coordinator_id :integer
#  location       :string(255)
#  start          :date
#  end            :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  latitude       :float
#  longitude      :float
#  gmaps          :boolean
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
	before { 
		@event_one = events(:event_one) 
		@coord_one = coordinators(:coord_one)
		@coord_two = coordinators(:coord_two)
	}
  let(:simple_event) {Event.new(name: 'TestName', about: 'TestAbout', location: 'MyString', start: '2013-05-31', end: '2013-05-31', latitude: nil, longitude: nil, gmaps: true)}
  it 'can create a new Event' do
    simple_event.valid?.must_equal true
  end

  it 'requires a name' do
    simple_event.name = nil
    simple_event.valid?.must_equal false
  end

  it 'should be unique per coordinator id' do
  	simple_event.coordinator = @coord_one
  	simple_event.save.must_equal true
  	# try to save again with exact same info
  	new_event = simple_event.clone
  	new_event.id = nil
  	new_event.valid?.must_equal false
  	# change coordinator id and all is fixed!
  	new_event.coordinator = @coord_two
  	new_event.valid?.must_equal true
  end
end
