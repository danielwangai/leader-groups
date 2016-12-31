class Contribution < ApplicationRecord
  # relationships
  belongs_to :member
  belongs_to :harambee

  # validations
  # validates :amount, presence: true
end
