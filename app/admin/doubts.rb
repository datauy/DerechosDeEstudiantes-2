ActiveAdmin.register Doubt do
  actions :all, :except => [:new, :edit]
  permit_params :name, :email, :message, :right_id
  belongs_to :right, optional: true

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message
    column :right_id do |q|
      link_to "#{q.right.id}: #{q.right.title}", admin_right_path(q.right)
    end
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :right_id
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :message
      f.input :right_id, :label => 'Derecho', :as => :select, :collection => Right.all.map{|r| ["#{r.id}: #{r.title}", r.id]}
      f.input :right_id
    end
    f.actions
  end

  controller do
    def scoped_collection
      if current_user.school_type.nil?
        return resource_class
      else
        school_type_relation = Right.where(school_type: current_user.school_type).pluck(:id)
        both_relation = Right.where(school_type: "ambas").pluck(:id)
        return resource_class.where(right_id: (school_type_relation + both_relation))
      end
    end
  end
end