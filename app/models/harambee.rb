class Harambee < ApplicationRecord
  # relationships
  has_many :contributions

  # validations
  validates :description, :target_amount, presence: true
end
