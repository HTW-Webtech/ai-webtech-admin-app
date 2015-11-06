module AppFetching
  def fetch_app(permalink_or_id)
    App.for_permalink_or_id(permalink_or_id).tap do |app|
      if app.user != current_user || current_user.admin?
        redirect_to current_user
      end
    end
  end
end
