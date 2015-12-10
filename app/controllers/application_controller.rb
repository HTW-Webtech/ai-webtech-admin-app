class ApplicationController < ActionController::Base
  force_ssl if: :ssl_configured?
	before_action :authorize_mini_profiler

  private

  def authorize_mini_profiler
    if current_user && current_user.admin?
      Rack::MiniProfiler.authorize_request
    end
  end

  def ssl_configured?
    Rails.env.production?
  end
end
