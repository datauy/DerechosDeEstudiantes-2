class AddIsPublicToQuestions < ActiveRecord::Migration[5.2]
  def up
    add_column :questions, :is_public, :boolean, :default => false
  end
  def down
    remove_column :questions, :is_public
  end
end
