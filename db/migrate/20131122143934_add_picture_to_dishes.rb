class AddPictureToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :picture, :string
  end
end
