class AddFieldsToComplains < ActiveRecord::Migration[5.2]
  def up
    add_column :complains, :location, :string
    add_column :complains, :institution, :string
    add_column :complains, :phone, :string
    add_column :complains, :to_who, :string
  end

  def down
    remove_column :complains, :location
    remove_column :complains, :institution
    remove_column :complains, :phone
    remove_column :complains, :to_who
  end
end
