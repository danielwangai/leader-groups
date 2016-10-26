class Role < ApplicationRecord
  # relationships
  has_many :users

  # validations
  validates :role_name, presence: true
end
