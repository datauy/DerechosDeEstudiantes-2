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
        resource_class
      else
        resource_class.where(right_id: Right.where(school_type: current_user.school_type).pluck(:id))
      end
    end
  end
end