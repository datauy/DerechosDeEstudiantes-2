class ChangeDefaultIsUser < ActiveRecord::Migration[5.2]
  def change
    change_column :answers, :is_user, :boolean, :default => false
  end
end
