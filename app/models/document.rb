class Document < ApplicationRecord
  # relationships
  belongs_to :archive

  has_attached_file :book, styles: {thumbnail: "60x60#"}
  validates_attachment :book, content_type: { content_type: "application/pdf" }
end
