class AppsController < ApplicationController
  include AppFetching

  def index
    redirect_to current_user
  end

  def show
    @app = fetch_app(params[:id])
  end

  def new
    @app = App.new(user: current_user)
  end

  def edit
    @app = fetch_app(params[:id])
    render :edit
  end

  def create
    @app = App.new(app_params)
    if @app.save
      redirect_to user_app_path(@app.user, @app), notice: 'Changes are being propagated. It may take 1-2 min. Check the app status icon.'
    else
      render :edit, flash: 'Please check your input!'
    end
  end

  def update
    @app = fetch_app
    if @app.update(app_params)
      redirect_to user_app_path(@app.user, @app), notice: "Successfully updated #{@app.name}"
    else
      render :edit
    end
  end

  private

  def app_params
    params.require(:app).permit(
      :name, :email, :ssh_key, :env_vars_view,
      :pg_host, :pg_database, :pg_login, :pg_passwd
    ).merge(user_id: current_user.id)
  end
end
