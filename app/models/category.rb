class Category < ApplicationRecord
  has_and_belongs_to_many :stations

  scope :top_level, -> { where(ancestry: nil) }

  extend FriendlyId
  friendly_id :title, use: :slugged
end
