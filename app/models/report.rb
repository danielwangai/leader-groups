class Report < ApplicationRecord
  # relationships
  belongs_to :user

  # validations
  validates :title, :content, :number_of_attendees, :user_id, presence: true
end
