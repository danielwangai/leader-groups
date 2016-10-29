class Member < ApplicationRecord
  # relationships
  belongs_to :group
  has_many :event_members
  has_many :events
  # validations
  validates :first_name, :last_name, presence: true
end
