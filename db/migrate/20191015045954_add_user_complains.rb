class AddUserComplains < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :for_complain, :boolean, :default => false
  end
  def down
    remove_column :users, :for_complain
  end
end
