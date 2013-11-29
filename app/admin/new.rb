ActiveAdmin.register New do
  config.sort_order = "id_desc"
  menu :priority => 5, url: ->{ admin_news_index_path(locale: I18n.locale) }

  filter :title
  filter :content

  form do |f|
    f.inputs do
      f.input :title
      #f.input :content, :as => :ckeditor, :input_html => { :ckeditor => {:toolbar => 'mini'} }
      f.input :content
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
