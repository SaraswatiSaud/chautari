class AddRatingToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :rating, :integer, default: 0
    add_column :stations, :average_rating, :decimal, precision: 6, scale: 2, default: 0
  end
end
