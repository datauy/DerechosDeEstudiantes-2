ActiveAdmin.register Question do
  permit_params :name, :email, :message, :grade, :institution, :location, :is_public, :collage

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
    column :collage
    column :count_help
    column :created_at
    column "", :id do |q|
      link_to "Responder", new_admin_answer_path(:post => { :question_id => q })
    end
    actions
  end

  filter :name
  filter :email
  filter :is_public
  filter :collage, as: :select, collection: Question.collages
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :message
      f.input :grade
      f.input :institution
      f.input :location
      f.input :collage, :label => 'Subsistema', :as => :select, :collection => Question.collages.keys.map{|r| [r, r]}
      f.input :is_public
    end
    f.actions
  end

  controller do
    def scoped_collection
      if current_user.school_type.nil?
        resource_class
      else
        resource_class.where(collage: current_user.school_type)
      end
    end
  end

end
