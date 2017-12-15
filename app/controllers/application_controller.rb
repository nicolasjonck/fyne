class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    new_swipe_path
  end

  # def after_update_path_for(resource)
  #   profile_path
  # end

  def user_root_path
    profile_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :city, :photo])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :city, :photo])
  end

end
