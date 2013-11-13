class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :contact
      t.string :tel
      t.string :fax
      t.string :qq
      t.string :address
      t.text :about

      t.timestamps
    end
  end
end
