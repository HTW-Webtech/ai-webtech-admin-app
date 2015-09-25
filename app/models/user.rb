class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :apps

  ADMIN_NAME = 'admin'

  def self.admin
    where(name: ADMIN_NAME).first!
  end

  def admin?
    persisted? && name == ADMIN_NAME
  end
end
