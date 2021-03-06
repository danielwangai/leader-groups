class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # relationships
  belongs_to :role
  belongs_to :group
  has_many :reports, dependent: :destroy

  # validations
  validates :username, presence: true

  def group_name_where_leader
    # returns the name of the group where user is a leader
    self.group.name
  end

  def admin?
    # for oversight group
    self.role.role_name == "Admin"
  end

  def regular?
    # for bs leaders
    self.role.role_name == "Regular"
  end
end
