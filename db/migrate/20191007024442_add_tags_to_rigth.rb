class AddTagsToRigth < ActiveRecord::Migration[5.2]
  def up
    add_column :rights, :tag_one, :string
    add_column :rights, :tag_two, :string
    add_column :rights, :tag_three, :string
    add_column :rights, :tag_four, :string
  end
  def down
    remove_column :rights, :tag_one
    remove_column :rights, :tag_two
    remove_column :rights, :tag_three
    remove_column :rights, :tag_four
  end
end
