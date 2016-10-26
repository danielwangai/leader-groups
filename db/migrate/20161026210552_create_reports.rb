class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.integer :number_of_attendees
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
