class CreateStationsAndStreams < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :name
      t.string :country
      t.string :slug
      t.string :logo
      t.string :website
      t.string :twitter
      t.string :facebook
      t.string :total_listeners
      t.jsonb :settings

      t.timestamps
    end

    create_table :categories_stations do |t|
      t.references :category, foreign_key: true
      t.references :station, foreign_key: true

      t.timestamps
    end

    create_table :streams do |t|
      t.references :station, foreign_key: true
      t.string :url
      t.integer :bitrate
      t.string :content_type
      t.integer :status
      t.integer :listeners

      t.timestamps
    end
  end
end
