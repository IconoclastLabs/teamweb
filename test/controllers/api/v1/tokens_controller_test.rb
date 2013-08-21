require 'test_helper'

# trying to take cues from these articles:
# http://matthewlehner.net/rails-api-testing-guidelines/
# http://www.emilsoman.com/blog/2013/05/18/building-a-tested/

describe Api::V1::TokensController do

	describe "/api/v1/tokens" do

		setup do
			@user = users(:one)
		end

		describe "create a token" do
			it "complains if the request is not in JSON format" do
				post :create, format: :http
				json_response = JSON.parse response.body
				json_response["message"].must_match "The request must be json"
				response.status.must_equal 406 #  406 Not Acceptable
			end

			it "complains if the email address is not posted" do
				post :create, format: :json, password: '123456789'
				json_response = JSON.parse response.body
				json_response["message"].must_match "The request must contain the user email and password."
				response.status.must_equal 400 # 400 Bad Request
		  end

			it "complains if the user password is not posted" do
				post :create, format: :json, email: @user.email
				json_response = JSON.parse response.body
				json_response["message"].must_match "The request must contain the user email and password."
				response.status.must_equal 400 # 400 Bad Request
		  end

			it "complains if the user does not exist" do
				post :create, format: :json, email: 'invalid@nowhere.com', password: "asdafsdaf"
				json_response = JSON.parse response.body
				json_response["message"].must_match "Invalid email or password."
				response.status.must_equal 401 # 401 Unauthorized
			end

			it "complains if the user's password is wrong" do
				post :create, format: :json, email:  @user.email, password: "asdafsdaf"
				json_response = JSON.parse response.body
				json_response["message"].must_match "Invalid email or password."
				response.status.must_equal 401 # 401 Unauthorized
			end

			it "responds with the token if the email/password is correct" do
				post :create, format: :json, email:  @user.email, password: '123456789'
				json_response = JSON.parse response.body
				json_response['token'].wont_be_nil
				#ap json_response # contains the user's API token
				response.status.must_equal 200 # 200 Ok
			end
		end
	end	

	describe "/api/v1/tokens/:id" do

		setup do
			@user = users(:one)
			# ensure a token exists
			post :create, format: :json, email:  @user.email, password: '123456789'
			@token_response = JSON.parse response.body
		end

		describe "delete" do
			it "should complain if the token is not found" do
				delete :destroy, api_v1_token_path(id: 123), id: 123, format: :json
				delete_response = JSON.parse response.body
				delete_response['message'].must_match "Invalid token."
				response.status.must_equal 404
			end
			it "respond with the token that is successfully delete" do
				delete :destroy, api_v1_token_path(@token_response['token']), id: @token_response['token'], format: :json
				response.status.must_equal 200
			end
		end
	end

end