class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_admin_user!
    redirect_to root_path, alert: "WARNING: You are not authorized to this area." unless current_user.try(:admin?)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
