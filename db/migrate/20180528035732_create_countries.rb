class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :iso_code
      t.string :name

      t.timestamps
    end

    add_reference :stations, :country, index: true
    add_foreign_key :stations, :countries
  end
end
