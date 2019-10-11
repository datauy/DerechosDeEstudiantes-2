ActiveAdmin.register Right do
  permit_params :list, :of, :attributes, :on, :model

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :tag_one
    column :tag_two
    column :tag_three
    column :tag_four
    column :created_at
    actions
  end

  filter :title
  filter :tag_one
  filter :tag_two
  filter :tag_three
  filter :tag_four
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :tag_one
      f.input :tag_two
      f.input :tag_three
      f.input :tag_four
    end
    f.actions
  end
end