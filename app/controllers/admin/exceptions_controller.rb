module Admin
  class ExceptionsController < BaseController
    def create
      raise StandardError, "Bla"
    end
  end
end
