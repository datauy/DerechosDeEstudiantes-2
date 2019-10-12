ActiveAdmin.register Answer do
  permit_params :name, :email, :message, :question_id
  belongs_to :question, optional: true

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message
    column :is_user
    column :question_id do |q|
      link_to "#{q.question.id}: #{q.question.message}", admin_question_path(q.question)
    end
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :is_user
  filter :question_id

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :message
      f.input :question_id, :label => 'Pregunta', :as => :select, :collection => Question.all.map{|q| ["#{q.id}: #{q.message}", q.id]}
    end
    f.actions
  end

  after_create do |answer|
    AdminMailer.with(answer: answer, url: question_url(answer.question.id)).send_answer.deliver
  end

end
