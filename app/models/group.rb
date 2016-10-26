class Group < ApplicationRecord
  # relationships
  has_many :users
  has_many :members

  # validations
  validates :name, presence: true
end
