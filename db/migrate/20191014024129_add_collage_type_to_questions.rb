class AddCollageTypeToQuestions < ActiveRecord::Migration[5.2]
  def up
    add_column :questions, :collage, :string
  end
  def down
    remove_column :questions, :collage
  end
end
