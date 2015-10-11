module Apiv1
  class BaseController < ::ApplicationController
    before_action :authenticate_client

    private

    def authenticate_client
      encrypted_base64 = request.headers['x-client-auth-encrypted-base64']
      data = request.headers['x-client-auth-original']
      auth = Apiv1::ClientAuth.new

      unless auth.valid?(encrypted_base64, data)
        render json: JSON.generate({ result: 'unauthorized' }), status: :unauthorized
      end
    end
  end
end
