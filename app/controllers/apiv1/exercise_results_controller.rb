module Apiv1
  class ExerciseResultsController < BaseController
    def create
      app = App.where(name: params[:app_name]).first!
      report = JSON.parse(request.body.string)
      exercise_id = params[:exercise_id]
      failures_count = report['failures_count']
      result = ExerciseResult.new(app: app, exercise_id: exercise_id, failures_count: failures_count)
      if result.save!
        render json: JSON.generate({ status: 'ok' })
      else
        render json: JSON.parse({ status: 'error', result: result.errors.to_s })
      end
    end
  end
end
