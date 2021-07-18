class AddIsPublicToAnswers < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :is_public, :boolean, default: true
  end
end
