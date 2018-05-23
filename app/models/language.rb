class Language < ApplicationRecord
  has_many :stations

  extend FriendlyId
  friendly_id :title, use: :slugged
end
