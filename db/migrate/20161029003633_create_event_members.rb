class CreateEventMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :event_members do |t|
      t.references :event, foreign_key: true
      t.references :member, foreign_key: true

      t.timestamps
    end
  end
end
