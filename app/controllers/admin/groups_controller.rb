module Admin
  class GroupsController < BaseController
    def show
      @group = Group.find(params[:id])
    end
  end
end
