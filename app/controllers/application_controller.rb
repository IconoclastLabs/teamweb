class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, except: [:index, :show, :list]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up, :account_update) { |u| u.permit(:username, :email) }
    default_params.permit(:username, :email, :name, :phone, :address)
  end


end
