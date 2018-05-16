class StaticPagesController < ApplicationController
  def home
    @stations = Station.distinct.joins(:streams).order(id: :desc).limit(12)
  end

  def search
    @stations = Station.distinct.joins(:streams).where("name ILIKE '%#{params[:query]}%'").order(id: :desc).limit(12)
  end
end
