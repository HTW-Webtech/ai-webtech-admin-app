class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :apps

  validate :allow_only_htwberlin_accounts, on: :create

  def self.admin
    where(name: cc(:admin).name).first!
  end

  def admin?
    persisted? && name == cc(:admin).name
  end

  def app_count
    apps.count
  end

  def total_points
    app_completed_points + app_review_points
  end

  def app_completed_points
    apps.exercise_completed.inject { |sum, app| app.points } || 0
  end

  def app_review_points
    apps.reviewed.count * 2
  end

  private

  # TODO: Move into validator class
  def allow_only_htwberlin_accounts
    unless !!email.match(/@htw-berlin.de\z/)
      self.errors[:email] << 'Muss eine @htw-berlin.de Adresse sein'
    end
  end
end
