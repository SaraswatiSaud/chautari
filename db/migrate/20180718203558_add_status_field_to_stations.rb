class AddStatusFieldToStations < ActiveRecord::Migration[5.2]
  def self.up
    add_column :stations, :status, :integer, null: false, default: 0
    change_column :streams, :status, :integer, null: false, default: 0
  end

  def self.down
    remove_column :stations, :status, :integer
  end
end
