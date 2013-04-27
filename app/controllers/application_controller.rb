class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do
    flash[:alert] = "This application is under trial period and all data will be cleared on final release."
  end

  def authenticate_admin_user!
    redirect_to root_path, alert: "WARNING: You are not authorized to this area." unless current_user.try(:admin?)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
