class Station < ApplicationRecord
  store_accessor :settings, :dirble_id
  mount_uploader :logo, LogoUploader

  has_and_belongs_to_many :categories
  has_many :streams, dependent: :destroy
end
