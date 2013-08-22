require 'test_helper'

# trying to take cues from these articles:
# http://matthewlehner.net/rails-api-testing-guidelines/
# http://www.emilsoman.com/blog/2013/05/18/building-a-tested/

describe Api::V1::OrganizationsController do
  #include Devise::TestHelpers
  describe  "/api/v1/organizations" do

    # describe "not_really_an_action.json" do
    #   it "should return a 404 error code" do
    #     get :not_really_an_action, format: :json
    #     assert_response :missing
    #   end
    # end

    describe "index" do
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
        assigns(:organizations).wont_be_nil
        @json_response.wont_be_nil
      end

      it "should contain at least one organization object" do
        assigns(:organizations).wont_be_nil
        @json_response['organizations'].size.must_be(:>, 0)
      end
    end

    describe "/api/v1/organizations/:id" do
      before do
        @organization = organizations(:coord_one)
        get :show, format: :json, id: @organization.id
        @json_response = JSON.parse response.body
      end

      it "displays a single organization" do
        @json_response['organization']['id'].must_equal @organization.id
      end
    end
  end
end
