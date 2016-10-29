class AddUserIdToMembers < ActiveRecord::Migration[5.0]
  def change
    add_reference :members, :user, foreign_key: true
  end
end
