class RenameQuestionToMessage < ActiveRecord::Migration[5.2]
  def up
    add_column :questions, :message, :text
    remove_column :questions, :question
  end
end
