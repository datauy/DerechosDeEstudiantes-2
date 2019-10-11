ActiveAdmin.register Question do
  permit_params :list, :of, :attributes, :on, :model

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message
    column :grade
    column :institution
    column :location
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :message
      f.input :grade
      f.input :institution
      f.input :location
    end
    f.actions
  end
end
