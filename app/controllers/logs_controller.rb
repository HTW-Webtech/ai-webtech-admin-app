class LogsController < ::BaseController
  include AppFetching

  def index
    @app = fetch_app(params[:app_id])
    @log_files = AppLogTailer::Index.new(@app).log_files
  end

  def show
    @log_file_name = params[:id]
    @app = fetch_app(params[:app_id])
    @log_content = AppLogTailer::Show.new(@app, @log_file_name).fetch
  end
end
