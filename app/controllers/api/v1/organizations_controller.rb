module Api
  module V1
    class OrganizationsController < ApplicationController
      respond_to :json
      before_filter :authenticate_user!
      
      def index
        @organizations = Organization.order(:name)
      end
    end
  end
end