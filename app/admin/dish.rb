ActiveAdmin.register Dish do


  controller do
    def permitted_params
      params.permit dish: [:title, :content]
    end
  end
end
