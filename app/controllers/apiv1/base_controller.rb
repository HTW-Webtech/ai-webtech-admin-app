module Apiv1
  class BaseController < ::ApplicationController
    protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
    # TODO
    # before_action :authenticate_client

    private

    def authenticate_client
    end
  end
end
