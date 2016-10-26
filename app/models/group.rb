class Group < ApplicationRecord
  # relationships
  has_many :users

  # validations
  validates :name, presence: true
end
