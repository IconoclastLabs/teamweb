module Api
  module V1
    class OrganizationsController < ApplicationController
      respond_to :json
      def index
        @organizations = Organization.order(:name)
      end
    end
  end
end