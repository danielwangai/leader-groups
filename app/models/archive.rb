class Archive < ApplicationRecord
  # relationships
  has_many :documents

  # validations
  validates :title, :description, presence: true
end
