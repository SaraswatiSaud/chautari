class StaticPagesController < ApplicationController
  def home
    @stations = Station.order(id: :desc).limit(12)
  end

  def search
    @stations = Station.where("name ILIKE '%#{params[:query]}%'").order(id: :desc).limit(12)
  end
end
