require 'test_helper'

describe "HomeControllerTest" do
  include Devise::TestHelpers
  
  it "gets index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:upcoming_events)
    1.must_equal 2
  end

end
