class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :apps

  validate :allow_only_htwberlin_accounts, on: :create

  def self.admin
    where(email: cc(:admin).email).first!
  end

  def self.without_admin
    where.not(email: cc(:admin).email)
  end

  def admin?
    persisted? && email == cc(:admin).email
  end

  def display_name
    (name.present? && name) || email
  end

  def app_count
    apps.count
  end

  def total_points
    apps.inject(0) { |sum, app| sum + app.total_points } || 0
  end

  private

  # TODO: Move into validator class
  def allow_only_htwberlin_accounts
    unless !!email.match(/@htw-berlin.de\z/)
      self.errors[:email] << 'Muss eine @htw-berlin.de Adresse sein'
    end
  end
end
