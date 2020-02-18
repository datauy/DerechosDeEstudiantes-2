ActiveAdmin.register Complain do
  menu :if => proc{ can? :manage, Complain }
  actions :all, :except => [:new, :edit]
  permit_params :name, :email, :message, :phone, :location, :institution, :to_who

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone
    column :location
    column :institution
    column :to_who
    column :message
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :message
  filter :to_who
  filter :location
  filter :created_at
end
