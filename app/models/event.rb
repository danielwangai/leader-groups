class Event < ApplicationRecord
  # relationships
  has_many :event_members
  has_many :members, through: :event_members

  # validations
  validates :name, presence: true
end
