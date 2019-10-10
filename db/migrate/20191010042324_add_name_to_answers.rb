class AddNameToAnswers < ActiveRecord::Migration[5.2]
  def up
    add_column :answers, :name, :string
    add_column :answers, :email, :string
  end
  def down
    remove_column :answers, :name
    remove_column :answers, :email
  end
end
