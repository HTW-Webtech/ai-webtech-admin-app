module Admin
  class AppReviewsController < BaseController
    include AppFetching

    def show
      @app = fetch_app(params[:app_id])
    end

    def confirm
      @app = fetch_app(params[:app_id])
      @app.update!(reviewed_at: Time.current)
      redirect_to root_path
    end

    def revoke
      @app = fetch_app(params[:app_id])
      @app.update!(reviewed_at: nil)
      redirect_to root_path
    end
  end
end
