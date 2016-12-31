class CreateHarambees < ActiveRecord::Migration[5.0]
  def change
    create_table :harambees do |t|
      t.text :description
      t.integer :target_amount

      t.timestamps
    end
  end
end
