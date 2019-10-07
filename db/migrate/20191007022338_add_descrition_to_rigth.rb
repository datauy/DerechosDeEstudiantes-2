class AddDescritionToRigth < ActiveRecord::Migration[5.2]
  def up
    add_column :rights, :description, :text
  end
  def down
    remove_column :rights, :description
  end
end
