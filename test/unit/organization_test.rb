# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  about      :string(255)
#  location   :string(255)
#  contact    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  let(:simple_coordinator) {Organization.new(name: 'TestName', about: 'TestAbout', location: 'Kansas', contact: 'TestContact')}

  it 'can create a new category' do
    simple_coordinator.valid?.must_equal true
  end

  it 'requires a name' do
    simple_coordinator.name = nil
    simple_coordinator.valid?.must_equal false
  end

  it 'name legnth between 2 and 38' do
    simple_coordinator.name = "joe"
    simple_coordinator.valid?.must_equal true
    simple_coordinator.name = "j" # too short
    simple_coordinator.valid?.must_equal false
    simple_coordinator.name = "j" * 40 # too long
    simple_coordinator.valid?.must_equal false
  end

  it 'requires contact info' do
    simple_coordinator.contact = nil
    simple_coordinator.valid?.must_equal false
  end

  it 'contact legnth between 2 and 38' do
    simple_coordinator.contact = "joe@yahoo.com"
    simple_coordinator.valid?.must_equal true
    simple_coordinator.contact = "j" # too short
    simple_coordinator.valid?.must_equal false
    simple_coordinator.contact = "j" * 40 # too long
    simple_coordinator.valid?.must_equal false
  end

  it 'can have events' do
    assert_respond_to(simple_coordinator, :events)
  end

  it 'can have users' do
    assert_respond_to(simple_coordinator, :users)
  end
end
