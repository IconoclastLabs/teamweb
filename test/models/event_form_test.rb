require 'test_helper'

class EventFormTest < ActiveSupport::TestCase

  before do
    @event_form = EventForm.new
  end

  it "has an organization object" do
    assert_respond_to(@event_form, :organization)
  end

  it "has a season object" do
    assert_respond_to(@event_form, :season)
  end

  it "has an event object" do
    assert_respond_to(@event_form, :event)
  end

  it "requires valid info to save" do
    @event_form.valid?.must_equal false
  end

end
