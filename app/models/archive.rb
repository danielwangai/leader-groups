class Archive < ApplicationRecord
  # relationships
  has_many :documents

  # validations
  validates :title, :description, presence: true

  accepts_nested_attributes_for :documents,
									reject_if: proc { |attributes| attributes['book'].blank? },
									allow_destroy: true
end
