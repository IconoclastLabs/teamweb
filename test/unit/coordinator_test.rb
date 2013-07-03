require 'test_helper'

class CoordinatorTest < ActiveSupport::TestCase
  let(:simple_coordinator) {Coordinator.new(name: 'TestName', about: 'TestAbout', location: 'TestLocation', contact: 'TestContact')}

  it 'can create a new category' do
    simple_coordinator.valid?.must_equal true
  end

  it 'requires a name' do
    simple_coordinator.name = nil
    simple_coordinator.valid?.must_equal false
  end
  it 'requires contact info' do
    simple_coordinator.contact = nil
    simple_coordinator.valid?.must_equal false
  end
end
