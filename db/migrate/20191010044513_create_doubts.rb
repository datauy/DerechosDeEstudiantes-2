class CreateDoubts < ActiveRecord::Migration[5.2]
  def change
    create_table :doubts do |t|
      t.text :message
      t.references :right, foreign_key: true
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
