module Admin
  class AppReviewsController < BaseController
    def show
      @app = find_app
    end

    def confirm
      @app = find_app
      @app.update!(reviewed_at: Time.current)
      redirect_to root_path
    end

    def revoke
      @app = find_app
      @app.update!(reviewed_at: nil)
      redirect_to root_path
    end

    private
    def find_app
      App.find(params[:app_id])
    end
  end
end
