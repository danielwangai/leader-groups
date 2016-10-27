class AddArchiveIdToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_reference :documents, :archive, foreign_key: true
  end
end
