class AddNameAndEmailToAnswer < ActiveRecord::Migration[5.2]
  def up
    add_column :questions, :name, :string
    add_column :questions, :email, :string
  end
  def down
    remove_column :questions, :name
    remove_column :questions, :email
  end
end
