class RemoveCountryFromStations < ActiveRecord::Migration[5.2]
  def change
    remove_column :stations, :country, :string
  end
end
