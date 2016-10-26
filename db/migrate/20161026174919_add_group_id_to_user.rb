class AddGroupIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :group, foreign_key: true
  end
end
