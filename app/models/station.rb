class Station < ApplicationRecord
  store_accessor :settings, :dirble_id
  mount_uploader :logo, LogoUploader

  has_and_belongs_to_many :categories
  before_destroy { categories.clear }

  has_many :streams, dependent: :destroy
  belongs_to :language

  paginates_per 15

  extend FriendlyId
  friendly_id :name, use: :slugged
end
