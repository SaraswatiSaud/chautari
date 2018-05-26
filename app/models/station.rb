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

  validates :name, :language_id, :country, presence: true
  before_validation :strip_whitespace

  private
  def strip_whitespace
    self.name.try(:strip!)
  end
end
