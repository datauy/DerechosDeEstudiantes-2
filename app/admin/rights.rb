ActiveAdmin.register Right do
  permit_params :title, :description, :tag_one, :tag_two, :tag_three, :tag_four, :school_type

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :tag_one
    column :tag_two
    column :tag_three
    column :tag_four
    column :school_type
    column :count_help
    column :created_at
    actions
  end

  filter :title
  filter :tag_one
  filter :tag_two
  filter :tag_three
  filter :tag_four
  filter :school_type, as: :select, collection: Right.school_types
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :tag_one
      f.input :tag_two
      f.input :tag_three
      f.input :tag_four
      f.input :school_type, :label => 'Subsistema', :as => :select, :collection => Right.school_types.keys.map{|r| [r, r]}
    end
    f.actions
  end

  controller do
    def scoped_collection
      if current_user.school_type.nil?
        return resource_class
      else
        school_type_relation = resource_class.where(school_type: current_user.school_type).pluck(:id)
        both_relation = resource_class.where(school_type: "ambas").pluck(:id)
        return resource_class.where(id: (school_type_relation + both_relation))
      end
    end
  end
end