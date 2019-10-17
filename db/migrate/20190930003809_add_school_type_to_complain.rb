class AddSchoolTypeToComplain < ActiveRecord::Migration[5.2]
  def up
    add_column :questions, :school_type, :integer
  end
  def down
    remove_column :questions, :school_type
  end
end
