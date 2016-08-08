class FeedbacksController < ApplicationController
  before_action :find_app_and_feedback, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def new
    @feedback = Feedback.new(feedback_params)
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to @feedback.app
    else
      render :new
    end
  end

  def update
    @feedback = @app.feedback
    if @feedback.update(feedback_params)
      redirect_to @feedback.app
    else
      render :edit
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.fetch(:feedback, {}).merge(app_id: params[:app_id]).permit(:body, :app_id)
    end

    def find_app_and_feedback
      @app = App.find(params[:app_id])
      @feedback = @app.feedback
    end
end
