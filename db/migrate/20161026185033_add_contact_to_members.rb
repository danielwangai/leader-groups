class AddContactToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :phone_number, :string
    add_column :members, :email, :string
  end
end
