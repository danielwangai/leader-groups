class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # relationships
  belongs_to :role

  # validations
  validates :username, presence: true


  def admin?
    # for oversight group
    self.role.role_name == "Admin"
  end

  def regular?
    # for bs leaders
    self.role.role_name == "Regular"
  end
end
