class AddAttachmentBookToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.attachment :book
    end
  end

  def self.down
    remove_attachment :documents, :book
  end
end
