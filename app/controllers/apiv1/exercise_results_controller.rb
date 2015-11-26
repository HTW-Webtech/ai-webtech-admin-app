module Apiv1
  class ExerciseResultsController < BaseController
    def create
      exercise_result = params[:exercise_result]
      if exercise_result[:success] == true
        app = App.for_permalink_or_id(params[:app_permalink])
        exercise_id = params[:exercise_id]
        result = ExerciseResult.new(app: app, exercise_id: exercise_id)
        if result.save!
          PointMaster.evaluate!(result)
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
