class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :station
      t.string :body
      t.integer :status, default: 0, null: false

      t.timestamps
    end
    add_column :stations, :reviews_count, :integer, default: 0
  end
end
