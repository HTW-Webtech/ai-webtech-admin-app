class AppsController < ApplicationController
  def index
    redirect_to current_user
  end

  def show
    @app = fetch_app
  end

  def new
    @app = App.new.tap do |app|
      app.name    = AppName.generate_unique
      app.email   = current_user.email
      app.ssh_key = current_user.ssh_key
    end
  end

  def edit
    @app = fetch_app
    render :edit
  end

  def create
    @app = App.new(app_params)
    if @app.save
      redirect_to user_app_path(@app.user, @app)
    else
      render :edit, flash: 'Please check your input!'
    end
  end

  def update
    @app = fetch_app
    if @app.update(app_params)
      redirect_to user_app_path(@app.user, @app), flash: 'Successfully updated'
    else
      render :edit
    end
  end

  private

  def app_params
    params.require(:app).permit(:name, :email, :ssh_key, :env_vars).merge(user_id: current_user.id)
  end

  def fetch_app
    App.find(params[:id]).tap do |app|
      redirect_to current_user unless app.user == current_user
    end
  end
end
