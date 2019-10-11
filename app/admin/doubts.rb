ActiveAdmin.register Doubt do
  actions :all, :except => [:new, :edit]
  permit_params :list, :of, :attributes, :on, :model
  belongs_to :right, optional: true

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message
    column :right_id do |q|
      link_to q.right.title, admin_right_path(q.right)
    end
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
      f.input :right_id
    end
    f.actions
  end
end