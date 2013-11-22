ActiveAdmin.register Dish do
  config.sort_order = "id_desc"
  menu :priority => 4

  index do
    column :id
    column :title
    column :content do |dish|
      truncate(dish.content, :length => 15)
    end
    default_actions
  end
  filter :title
  filter :content

  form do |f|
    f.inputs do
      f.input :title
      f.input :picture
      f.input :content
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :picture do |dish|
        image_tag dish.picture_url
      end
      row :content
      row :created_at
    end
  end

  controller do
    def permitted_params
      params.permit dish: [:title, :content, :picture]
    end
  end
end
