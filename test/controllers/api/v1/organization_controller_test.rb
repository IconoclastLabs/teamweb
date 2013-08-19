require 'test_helper'

class Api::V1::OrganizationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  # trying to take cues from these articles: 
  # http://matthewlehner.net/rails-api-testing-guidelines/
  # http://www.emilsoman.com/blog/2013/05/18/building-a-tested/
  describe  "/api/v1/organizations" do
    
    describe "not_really_an_action.json" do
      it "should return a 404 error code" do
        get :not_really_an_action, format: :json
        assert_response :missing
      end
    end

    describe "index.json" do
      before do
        get :index, format: :json
        @json_response = JSON.parse response.body
        @organization = organizations(:coord_one)
      end

      it "lists all organizations" do
        assigns(:organizations).wont_be_nil
        assert_response :success
      end

      it "responds with parsable JSON" do
        @json_response.wont_be_nil
      end

      it "should contain at least one organization object" do
        binding.pry 
        #json_response['']
      end
    end
  end
end
