class Role < ApplicationRecord
  # relationships
  has_many :users, dependent: :destroy

  # validations
  validates :role_name, presence: true
end
