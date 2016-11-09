class Broadcast < ApplicationRecord
  # validations
  validates :title, :content, presence: true
end
