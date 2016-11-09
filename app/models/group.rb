class Group < ApplicationRecord
  # relationships
  has_many :users, dependent: :destroy
  has_many :members, dependent: :destroy

  # validations
  validates :name, presence: true
end
