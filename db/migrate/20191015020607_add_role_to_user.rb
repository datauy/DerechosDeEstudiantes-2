class AddRoleToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :admin_type, :integer
    add_column :users, :school_type, :integer
  end
  def down
    remove_column :users, :user_type
    remove_column :users, :school_type
  end
end
