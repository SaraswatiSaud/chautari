class Review < ApplicationRecord
  enum status: [:pending, :active]

  belongs_to :user
  belongs_to :station
  after_save :refresh_reviews_ratings_count
  after_destroy :refresh_reviews_ratings_count

  validates :user_id, :body, presence: true

  delegate :email, :full_name, to: :user, prefix: true

  private

  def refresh_reviews_ratings_count
    station.refresh_reviews_ratings_count
  end
end
