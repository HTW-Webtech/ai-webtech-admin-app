class LogsController < ::BaseController
  include AppFetching

  def show
    @app = fetch_app(params[:app_id])
    @logs = @app.fetch_logs
  end
end
