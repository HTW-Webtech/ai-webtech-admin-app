module Apiv1
  class BaseController < ::ApplicationController
    AuthError = Class.new(Exception)

    # before_action :authenticate_client
    rescue_from AuthError, with: :handle_auth_error

    private

    def authenticate_client
      sign = request.headers['x-client-auth-signature'].to_s
      data = request.headers['x-client-data'].to_s
      if sign.blank?
        raise AuthError, 'x-client-auth-signature header missing'
      end
      if data.blank?
        raise AuthError, 'x-client-data header missing'
      end

      auth = Apiv1::ClientAuth.new
      if !auth.valid?(sign, data)
        raise AuthError, 'Unauthorized access'
      end
    end

    def handle_auth_error(exception)
      render json: JSON.generate({ result: 'unauthorized', message: exception.message }), status: :unauthorized
    end
  end
end
