ActiveAdmin.register Answer do
  permit_params :list, :of, :attributes, :on, :model
  belongs_to :question, optional: true

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message
    column :is_user
    column :question_id do |q|
      link_to q.question.message, admin_question_path(q.question)
    end
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
      f.input :question_id
    end
    f.actions
  end

end
