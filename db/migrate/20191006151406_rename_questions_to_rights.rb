class RenameQuestionsToRights < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :questions, :rights
  end

  def self.down
    rename_table :rights, :questions
  end
end
