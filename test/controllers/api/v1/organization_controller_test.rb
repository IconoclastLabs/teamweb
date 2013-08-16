require 'test_helper'

class Api::V1::OrganizationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  describe "#index.json" do
    before do
      get :index, format: :json
      @organization = organizations(:coord_one)
    end

    it "lists all organizations" do
      assigns(:organizations).wont_be_nil
      assert_response :success
    end

    it "responds with parsable JSON" do
      json_response = JSON.parse response.body
      json_response.wont_be_nil
    end
  end
end
