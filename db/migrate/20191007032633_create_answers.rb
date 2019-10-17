class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :message
      t.references :question, foreign_key: true
      t.boolean :is_user, default: true

      t.timestamps
    end
  end
end
