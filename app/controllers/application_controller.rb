class ApplicationController < ActionController::Base
  protect_from_forgery
  # This is our new function that comes before Devise's one
  before_filter :authenticate_user_from_token!

  before_filter :authenticate_user!, except: [:index, :show, :list]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :name, :phone, :address, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :name, :phone, :address, :password, :password_confirmation, :current_password) }
  end

	# # This method lets you set the 'X-API-KEY' request header with the user account's
	# # auth token. This method keeps the token out of the URL params to prevent
	# # confusion and logging less of sensitive information.
	# # Of course, if you pass a URL `auth_token` parameter, it will still work too.
 #  def get_api_key!
 #  	ap "get api key"
 #    if api_key = params[:auth_token].blank? && request.headers["X-API-KEY"]
 #      params[:auth_token] = api_key
 #      ap "getting api key: #{params}"
 #    end
 #    ap "auth the user via devise"
 #    authenticate_user!
 #    #ap "params_auth_hash: #{params_auth_hash}"
 #  end

  private
 
  # This lets us pass "X-API-EMAIL" and "X-API-KEY" request headers to authenticate
  # instead of HTTP basic auth every time, or worse, URL params
  def authenticate_user_from_token!

    user_email = request.headers["X-API-EMAIL"].presence
    user       = user_email && User.find_by_email(user_email)

    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    if user && Devise.secure_compare(user.authentication_token, request.headers["X-API-KEY"])
      sign_in user, store: false
    end
  end

end
