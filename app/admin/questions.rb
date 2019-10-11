ActiveAdmin.register Question do
  permit_params :name, :email, :message, :grade, :institution, :location, :is_public

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message
    column :grade
    column :institution
    column :location
    column :is_public
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :is_public
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :message
      f.input :grade
      f.input :institution
      f.input :location
      f.input :is_public
    end
    f.actions
  end
end
