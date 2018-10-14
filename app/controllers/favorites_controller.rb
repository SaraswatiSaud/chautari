class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_station, except: :index

  def index
    @favorites = current_user.favorites
    @pagy, @favorites = pagy(@favorites)
  end

  def create
    @station
  end

  def destroy
  end

  private

  def set_station
    @station = Station.friendly.find(params[:id])
  end
end
