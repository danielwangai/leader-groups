class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.references :member, foreign_key: true
      t.references :harambee, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
