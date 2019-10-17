ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :school_type, :admin_type, :for_complain

  index do
    selectable_column
    id_column
    column :email
    column :school_type
    column :admin_type
    column :for_complain
    actions
  end

  filter :email
  filter :school_type, as: :select, collection: User.school_types

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :school_type, :label => 'Subsistema', :as => :select, :collection => User.school_types.keys.map{|r| [r, r]}
      f.input :admin_type, :label => 'Tipo', :as => :select, :collection => User.admin_types.keys.map{|r| [r, r]}
      f.input :for_complain
    end
    f.actions
  end

end
