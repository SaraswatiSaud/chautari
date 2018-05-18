class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_admin!
    authenticate_user!
    redirect_to root_path, alert: 'You are not authorized to this action!' unless current_user.is_admin?
  end
end
