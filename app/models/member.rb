class Member < ApplicationRecord
  # relationships
  belongs_to :group

  # validations
  validates :first_name, :last_name, presence: true
end
