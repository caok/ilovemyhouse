ActiveAdmin.register Company do
  menu :priority => 3, url: ->{ admin_companies_path(locale: I18n.locale) }

  config.filters = false
  config.batch_actions = false
  actions :all, except: [:new, :create, :destroy]

  permit_params :name, :contact, :tel, :fax, :qq, :address, :about
end
