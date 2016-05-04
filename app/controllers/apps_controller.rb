class AppsController < ::BaseController
  include AppFetching
  before_action :limit_apps_per_user, only: [:new, :create]

  def index
    redirect_to current_user
  end

  def show
    @announcements = Announcement.all
    @app = fetch_app(params[:id])
  end

  def new
    @app = App.new(user: current_user).prefill
  end

  def edit
    @app = fetch_app(params[:id])
    render :edit
  end

  def create
    @app = App.new(app_params).prefill
    if @app.save
      @app.publish_to_app_service
      @app.publish_to_jenkins_service
      redirect_to user_path(current_user), notice: 'Changes are being propagated. It may take 1-2 min. Check the app status icon.'
    else
      render :edit, flash: 'Please check your input!'
    end
  end

  def destroy
    redirect_to user_path(current_user) unless current_user.admin?
    @app = fetch_app(params[:id])
    if @app.destroy!
      redirect_to user_path(current_user), notice: 'App has been destroyed!'
    else
      redirect_to user_path(current_user), notice: @app.errors.join("\n")
    end
  end

  def update
    @app = fetch_app(params[:id])
    if @app.update_attributes(app_params)
      @app.publish_to_app_service
      @app.publish_to_jenkins_service
      redirect_to user_path(current_user), notice: "Successfully updated #{@app.name}. It may take 2-3 min. for your changes to take action."
    else
      render :edit
    end
  end

  private

  def limit_apps_per_user
    if User::AppLimit.limit_reached? current_user
      redirect_to user_path(current_user), notice: "You are allowed to create only one app for each exercise"
    end
  end

  def app_params
    params.require(:app).permit(:name, :ssh_key).
      merge(user_id: current_user.id, course: user.course)
  end
end
