class Country < ApplicationRecord
  has_many :stations
  extend FriendlyId
  friendly_id :name, use: :slugged
end
