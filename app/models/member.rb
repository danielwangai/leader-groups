class Member < ApplicationRecord
  # relationships
  belongs_to :group
  has_many :contributions

  # validations
  validates :first_name, :last_name, presence: true
end
