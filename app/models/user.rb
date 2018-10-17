class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { scope: :email }
  validates :first_name, :last_name, presence: true

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def reviewed?(station)
    reviews.find_by(station_id: station.id).present?
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def favorite?(station)
    favorite(station).present?
  end

  def favorite(station)
    favorites.find_by(station_id: station.id)
  end
end
