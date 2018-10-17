class FavoritesController < ApplicationController
  include Favoritable

  before_action :authenticate_user!
  before_action :set_station, except: :index
  before_action :set_favorite, only: :destroy

  def index
    @favorites = current_user.favorites
    @pagy, @favorites = pagy(@favorites)

    @title = 'My Favorite Radio Stations'
  end

  def create
    current_user.favorites.create(station: @station)
    favorites_button(@station)
  end

  def destroy
    @favorite.destroy
    favorites_button(@station)
  end

  private

  def set_station
    @station = Station.friendly.find(params[:station_id])
  end

  def set_favorite
    @favorite = current_user.favorite(@station)
  end
end
