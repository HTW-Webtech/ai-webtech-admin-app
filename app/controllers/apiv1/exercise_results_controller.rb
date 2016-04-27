module Apiv1
  class ExerciseResultsController < BaseController
    def create
      exercise_result = json_body['exercise_result']
      if exercise_result['success'] == true
        app = App.for_permalink_or_id(exercise_result['app_name'])
        exercise_id = exercise_result['exercise_id'].to_i
        result = ExerciseResult.new(app: app, exercise_id: exercise_id)
        if result.save!
          ExercisePointMaster.new(app.course).evaluate!(result)
          render json: JSON.generate({ status: 'ok' })
        else
          render json: JSON.parse({ status: 'error', result: result.errors.to_s })
        end
      else
        render json: JSON.parse({ status: 'error', result: 'success was false' })
      end
    end

    def json_body
      @body ||= request.body.read
      JSON.parse(@body)
    end
  end
end
