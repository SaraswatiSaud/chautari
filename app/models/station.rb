class Station < ApplicationRecord
  store_accessor :settings, :dirble_id
  mount_uploader :logo, LogoUploader

  is_impressionable counter_cache: true, unique: true
  enum status: [:pending, :active, :archived]

  has_and_belongs_to_many :categories
  before_destroy { categories.clear }

  has_many :streams, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :language
  belongs_to :country

  paginates_per 15

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :country_id, :language_id, presence: true
  before_validation :strip_whitespace

  accepts_nested_attributes_for :streams, reject_if: :all_blank, allow_destroy: true

  delegate :name, to: :country, prefix: true, allow_nil: true
  delegate :title, to: :language, prefix: true, allow_nil: true

  def similar_stations
    Station.active.where(country_id: country_id)
      .or(Station.where(language_id: language_id))
      .or(Station.where(categories: categories))
      .where.not(id: self.id)
      .order(impressions_count: :desc)
      .limit(5)
  end

  def playing_now
    song = active_streams.first.try(:icy_metadata)
    return unless song.present?

    playing_now.present? ? "Playing Now: #{playing_now}" : country_name
  end

  def active_streams
    @active_streams ||= streams.active
  end

  def active_reviews
    @active_reviews ||= reviews.active
  end

  def average_rating
    @average_rating ||= get_average_rating
  end

  def full_address
    @full_address ||= join_array([address, country_name])
  end

  def categories_names
    @categories_names ||= join_array(categories.pluck(:title))
  end

  def meta_title
    @meta_title ||= "Listen to #{name}, #{full_address} | Jharko"
  end

  def meta_desc
    @meta_desc ||= (description? ? description.squish : default_meta_desc)
  end

  def meta_keywords
    @meta_keywords ||= join_array([name, tagline, 'free radio', categories_names, 'stream music', full_address, language_title.to_s + ' radio'].flatten)
  end

  def refresh_reviews_ratings_count
    update(reviews_count: active_reviews.size, average_rating: average_rating)
  end

  private

  def default_meta_desc
    str = "#{name} is a Radio Station streaming online from #{full_address}. "
    str += "This station plays content of categories - #{categories_names}. " if categories_names.present?
    str += "Listen to #{name} for free."
    str
  end

  def join_array(arr)
    arr.compact.reject(&:empty?).join(', ')
  end

  def strip_whitespace
    self.name.try(:strip!)
  end

  def get_average_rating
    ratings_sum = active_reviews.pluck(:rating).sum
    count = active_reviews.size
    count == 0 ? 0 : (ratings_sum.to_f / count)
  end
end
