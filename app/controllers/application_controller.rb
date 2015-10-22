class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Exception, with: -> { render_error(404) } unless Rails.application.config.consider_all_requests_local
  rescue_from ActiveRecord::RecordNotFound, with: -> { render_error(404) } unless Rails.application.config.consider_all_requests_local
  rescue_from ActionController::RoutingError, with: -> { render_error(404) } unless Rails.application.config.consider_all_requests_local

  def index
  end

  def render_error(status)
    respond_to do |format|
      format.html { render 'errors/404', status: status }
      format.all { render nothing: true, status: status }
    end
  end

  before_action :global_site_settings

  private

  def global_site_settings
    @global_site_settings ||= Optimadmin::SiteSetting.current_environment
  end
  helper_method :global_site_settings
end
