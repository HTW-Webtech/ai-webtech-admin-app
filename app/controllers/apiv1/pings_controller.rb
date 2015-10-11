require 'json'

module Apiv1
  class PingsController < BaseController
    def ping
      render json: JSON.generate({ result: 'pong' })
    end
  end
end
