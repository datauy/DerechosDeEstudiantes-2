class ChangeStringToIntCollage < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :collage, 'integer USING CAST(collage AS integer)'
  end
end
