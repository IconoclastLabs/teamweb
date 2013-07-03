require 'test_helper'

class EventTest < ActiveSupport::TestCase
  let(:simple_event) {Event.new(name: 'TestName', about: 'TestAbout', location: 'MyString', start: '2013-05-31', end: '2013-05-31')}
  it 'can create a new Event' do
    simple_event.valid?.must_equal true
  end

  it 'requires a name' do
    simple_event.name = nil
    simple_event.valid?.must_equal false
  end

end
