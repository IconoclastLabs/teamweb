require 'test_helper'
# https://github.com/intridea/omniauth/wiki/Integration-Testing
describe Users::OmniauthCallbacksController do
  #include Devise::TestHelpers
  describe "#facebook" do
    before do
      # set up our omniauth request
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = omniauth_facebook_sign_in()
      #User.stub(:from_omniauth).and_return(current_user)
    end
    describe "it can sign in users" do
      it "will sign in a user with omniauth if that user already exists" do
        skip "figure out how to add this info to a new user"
        begin
          post :facebook, user_omniauth_authorize_path(provider: "facebook"), provider: "facebook"
          assigns(:user).wont_be_nil
        rescue
          binding.pry
        end
      end

      it "will flash a success message after login" do
        skip "assert the content of the set_flash_message"
      end
    end

    describe "can redirect new users to account creation" do
      it "will set the omniauth data to session data if the user is not persisted" do
        skip "need to figure out how to fake the omniauth data still"
      end

      it "will redirect the user to the new_user_registration_url" do
        skip "assert the redirect"
      end
    end
  end
end
