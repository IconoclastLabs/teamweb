module Api
  module V1
    class OrganizationsController < ApplicationController
      respond_to :json
      before_filter :authenticate_user_from_token!

      def index
        @organizations = Organization.order(:name)
      end

      def show
        @organization = Organization.friendly.find(params[:id])
      end
    end
  end
end