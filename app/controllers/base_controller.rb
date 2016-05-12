class BaseController < ::ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :redirect_users_to_users_namespace
  before_action :ensure_user_belongs_to_one_group
  before_action :ensure_user_belongs_to_one_course
  before_action :notify_users_without_name
  before_action :notify_users_about_review_dates

  private

  def ensure_user_belongs_to_one_group
    if current_user && current_user.groups.empty?
      current_user.groups << Group.current_course
    end
  end

  def ensure_user_belongs_to_one_course
    if current_user && current_user.course.blank?
      current_user.update course: Courses.current.display_name
    end
  end

  def notify_users_without_name
    if current_user && current_user.name.blank?
      flash[:alert] = "Please set a name on your Profile page"
    end
  end

  def notify_users_about_review_dates
    if current_user
      ReviewDate.upcoming_for_user(current_user).each do |date|
        link_to_info = "<a href='https://portal.htw-webtech.com/site/courses/ss2016/index.html#code-review'>Mehr Infos zum CodeReview-Termin.</a>"
        add_flash type: :notice, message: "Du hast einen CodeReview-Termin (#{date.id}) für die #{date.exercise_id}te Aufgabe am #{date.begins_at.to_s(:long)} Uhr. Geplante Dauer: #{date.length_in_minutes} Min. #{link_to_info}.<br/>Wenn Eure Gruppe an dem Termin nicht teilnehmen kannst, meldet euch per E-Mail/Slack."
      end
    end
  end

  def redirect_users_to_users_namespace
    if current_user && !current_user.admin? && !request.path.start_with?("/users/")
      redirect_to user_path(current_user)
    end
  end

  def after_sign_in_path_for(_)
    user_path(current_user)
  end

  def add_flash(type:, message:)
    flash.now[type] ||= []
    flash.now[type] << message
  end
end
