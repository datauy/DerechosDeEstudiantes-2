class AddCountHelpToRightAndDoubts < ActiveRecord::Migration[5.2]
  def up
    add_column :questions, :count_help, :integer, :default => 0
    add_column :rights, :count_help, :integer, :default => 0
  end

  def down
    remove_column :questions, :count_help
    remove_column :rights, :count_help
  end
end
