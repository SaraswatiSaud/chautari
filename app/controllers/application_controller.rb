class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :set_vary_header

  def authenticate_admin!
    authenticate_user!
    redirect_to root_path, alert: 'You are not authorized to this action!' unless current_user.is_admin?
  end

  private

  def set_vary_header
    response.headers['Vary'] = 'accept' if request.xhr?
  end
end
