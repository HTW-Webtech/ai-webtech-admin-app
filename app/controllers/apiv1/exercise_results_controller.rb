module Apiv1
  class ExerciseResultsController < BaseController
    def create
      app = App.where(name: params[:app_name]).first!
      report = JSON.parse(request.body.string)
      exercise_id = params[:exercise_id]
      result = ExerciseResult.new(app: app, exercise_id: exercise_id)
      if result.save!
        render json: JSON.generate({ status: 'ok' })
      else
        render json: JSON.parse({ status: 'error', result: result.errors.to_s })
      end
    end
  end
end
