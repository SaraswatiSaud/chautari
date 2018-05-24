class AddFieldsToStation < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :tagline, :string
    add_column :stations, :address, :string
    add_column :stations, :contact, :string
    add_column :stations, :email, :string
  end
end
