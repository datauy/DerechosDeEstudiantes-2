ActiveAdmin.register Complain do
  menu :if => proc{ can? :manage, Complain }
  actions :all, :except => [:new, :edit]
  permit_params :name, :email, :message

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :message
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :message
  filter :created_at
end
