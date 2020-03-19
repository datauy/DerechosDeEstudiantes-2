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
      f.input :message, as: :ckeditor
      if params['post'].present?
        f.input :question_id, :label => 'Pregunta', :as => :select, :collection => Question.all.map{|q| ["#{q.id}: #{q.message}", q.id]}, selected: params['post']['question_id']
      else
        f.input :question_id, :label => 'Pregunta', :as => :select, :collection => Question.all.map{|q| ["#{q.id}: #{q.message}", q.id]}
      end
      f.inputs "Datos de la pregunta", for: [:question, f.object.question || Question.find(params['post']['question_id'])] do |meta_form|
        meta_form.input :is_public
      end
    end
    f.actions
  end

  controller do
    def scoped_collection
      if current_user.school_type.nil?
        resource_class
      else
        resource_class.where(question_id: Question.where(collage: current_user.school_type).pluck(:id))
      end
    end
  end

  after_create do |answer|
    answer.question.is_public = params['answer']['question_attributes']['is_public'] == '0' ? false : true
    answer.question.save
    AdminMailer.with(answer: answer, url: question_url(answer.question.id)).send_answer.deliver
  end

  after_update do |answer|
    answer.question.is_public = params['answer']['question_attributes']['is_public'] == '0' ? false : true
    answer.question.save
  end
end
