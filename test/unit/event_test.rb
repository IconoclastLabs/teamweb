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
  let(:simple_event) {Event.new(name: 'TestName', about: 'TestAbout', location: 'MyString', start: '2013-05-31', end: '2013-05-31', latitude: nil, longitude: nil, gmaps: true)}
  it 'can create a new Event' do
    simple_event.valid?.must_equal true
  end

  it 'requires a name' do
    simple_event.name = nil
    simple_event.valid?.must_equal false
  end

end
