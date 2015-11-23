module Apiv1
  class ExerciseResultsController < BaseController
    def create
      exercise_result = params[:exercise_result]
      if exercise_result[:success] == true
        app = App.where(name: params[:app_name]).first!
        exercise_id = params[:exercise_id]
        result = ExerciseResult.new(app: app, exercise_id: exercise_id)
        if result.save!
          render json: JSON.generate({ status: 'ok' })
        else
          render json: JSON.parse({ status: 'error', result: result.errors.to_s })
        end
      else
        render json: JSON.parse({ status: 'error', result: 'success was false' })
      end
    end
  end
end
