module AppFetching
  def fetch_app(app_id)
    App.find(app_id).tap do |app|
      if app.user != current_user && !current_user.admin?
        redirect_to current_user
      end
    end
  end
end
