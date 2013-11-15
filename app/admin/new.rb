ActiveAdmin.register New do
  form do |f|
    f.inputs do
      f.input :title
      f.input :content, :as => :ckeditor, :input_html => { :ckeditor => {:toolbar => 'mini'} }
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :content do |new|
        new.content.html_safe
      end
      row :created_at
    end
  end

  controller do
    def permitted_params
      params.permit new: [:title, :content]
    end
  end
end
