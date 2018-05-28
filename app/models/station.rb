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

  private
  def strip_whitespace
    self.name.try(:strip!)
  end
end
