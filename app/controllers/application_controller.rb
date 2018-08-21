class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :rediect_other_domains_if_any
  before_action :store_user_location!, if: :storable_location?
  after_action :set_vary_header

  def authenticate_admin!
    authenticate_user!
    redirect_to root_path, alert: 'You are not authorized to this action!' unless current_user.is_admin?
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || super
  end

  private

  def set_vary_header
    response.headers['Vary'] = 'accept' if request.xhr?
  end

  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def rediect_other_domains_if_any
    return unless Rails.env.production?

    if ENV['OTHER_DOMAINS'].split(',').any?(request.host)
      redirect_to "#{ENV['ROOT_URL']}/#{request.fullpath}", status: :moved_permanently
    end
  end
end
