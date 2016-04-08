class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  # :rememberable manages generating and clearing tokens from a cookie
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :confirmable

  has_many :apps
  has_and_belongs_to_many :groups, join_table: :groups_users

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
    "#{display_blocked}#{display_name_or_email}"
  end

  def display_name_or_email
    (name.present? && name) || email
  end

  def display_blocked
    "[B] " if blocked?
  end

  def app_count
    apps.count
  end

  def appraisal
    @appraisal ||= User::Appraisal.new(self)
  end

  def matrikel_number
    if m = email.match(%r{(s\d+)})
      m[0]
    else
      '-'
    end
  end

  def total_points
    apps.inject(0) { |sum, app| sum + app.total_points } || 0
  end

  def blocked?
    blocked_at && blocked_at < Time.current
  end

  def block!
    return false if admin?
    update! blocked_at: Time.current
  end

  def unblock!
    update! blocked_at: nil
  end

  private

  # TODO: Move into validator class
  def allow_only_htwberlin_accounts
    unless !!email.match(/@htw-berlin.de\z/)
      self.errors[:email] << 'Muss eine @htw-berlin.de Adresse sein'
    end
  end
end
