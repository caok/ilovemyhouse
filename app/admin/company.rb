ActiveAdmin.register Company do
  menu :priority => 3
  config.filters = false
  config.batch_actions = false
  actions :all, except: [:new, :create, :destroy]

  permit_params :name, :contact, :tel, :fax, :qq, :address, :about
end
