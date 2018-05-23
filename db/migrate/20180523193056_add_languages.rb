class AddLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end

    add_column :stations, :description, :string
    add_reference :stations, :language, foreign_key: true
  end
end
