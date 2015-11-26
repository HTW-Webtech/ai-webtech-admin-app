module Admin
  class AppReviewsController < BaseController
    include AppFetching

    def show
      @app = fetch_app(params[:app_id])
    end

    def confirm
      @app = fetch_app(params[:app_id])
      @app.update!(reviewed_at: Time.current, review_points: params[:points])
      redirect_to admin_app_review_path(@app)
    end

    def revoke
      @app = fetch_app(params[:app_id])
      @app.update!(reviewed_at: nil)
      redirect_to admin_app_review_path(@app)
    end
  end
end
