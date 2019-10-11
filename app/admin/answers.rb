ActiveAdmin.register Answer do
  permit_params :list, :of, :attributes, :on, :model

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message
    column :is_user
    column :question_id
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :is_user

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :message
      f.input :is_user
      f.input :question_id
    end
    f.actions
  end

end
