class Station < ApplicationRecord
  store_accessor :settings, :dirble_id
  mount_uploader :logo, LogoUploader

  has_and_belongs_to_many :categories
  before_destroy { categories.clear }

  has_many :streams, dependent: :destroy
  belongs_to :language
  belongs_to :country

  paginates_per 15

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :country_id, :language_id, presence: true
  before_validation :strip_whitespace

  accepts_nested_attributes_for :streams, reject_if: :all_blank, allow_destroy: true

  delegate :name, to: :country, prefix: true

  def similar_stations
    Station.where(country_id: country_id).or(Station.where(language_id: language_id)).or(Station.where(categories: categories)).limit(5)
  end

  def playing_now
    song = streams.first.icy_metadata if streams.any?
    song.present? ? "Playing Now: #{song.now_playing}" : country_name
  end

  private
  def strip_whitespace
    self.name.try(:strip!)
  end
end
