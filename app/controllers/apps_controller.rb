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
      @app.publish_to_app_service
      @app.publish_to_jenkins_service
      redirect_to user_app_path(@app.user, @app), notice: 'Changes are being propagated. It may take 1-2 min. Check the app status icon.'
    else
      render :edit, flash: 'Please check your input!'
    end
  end

  def update
    @app = fetch_app(params[:id])
    if @app.update_attributes(app_params)
      @app.publish_to_app_service
      @app.publish_to_jenkins_service
      redirect_to user_app_path(@app.user, @app), notice: "Successfully updated #{@app.name}. It may take 2-3 min. for your changes to take action."
    else
      render :edit
    end
  end

  private

  def app_params
    params.require(:app).permit(
      :name, :ssh_key, :pg_host, :pg_database, :pg_login, :pg_passwd
    ).merge(user_id: current_user.id, env_vars: env_vars_params)
  end

  def env_vars_params
    params[:env_vars] or return {}
    params[:env_vars].each_with_object({}) do |var, env_vars|
      env_vars[var['name'].upcase] = var['value']
    end
  end
end
