class CreateNewQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :location
      t.string :institution
      t.integer :grade
      t.text :question

      t.timestamps
    end
  end
end
