class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_organization, :organization_signed_in?, :warden_message

protected
  def current_organization
    warden.user(scope: :organization)
  end

  def organization_signed_in?
    warden.authenticate?(scope: :organization)
  end

  def authenticate!
    redirect_to root_path, notice: t('.not_logged') unless organization_signed_in?
  end

  def warden_message
    warden.message
  end

  def warden
    request.env['warden']
  end

end
