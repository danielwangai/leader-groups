class CreateBroadcasts < ActiveRecord::Migration[5.0]
  def change
    create_table :broadcasts do |t|
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
