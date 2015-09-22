module AppFetching
  def fetch_app(app_id)
    App.find(app_id).tap do |app|
      redirect_to current_user unless app.user == current_user
    end
  end
end
