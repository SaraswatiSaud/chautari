class Review < ApplicationRecord
  enum status: [:pending, :active]
  
  belongs_to :user
  belongs_to :station, counter_cache: true

  validates :user_id, :body, presence: true

  delegate :email, to: :user, prefix: true
end
