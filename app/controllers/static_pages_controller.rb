class StaticPagesController < ApplicationController
  def home
    @stations = Station.distinct.joins(:streams).order(id: :desc)
    @stations = @stations.where("name ILIKE '%#{params[:query]}%'") if params[:query].present?
    @stations = @stations.page(params[:page])
  end

  def contact
  end

  def about
  end

  def faq
  end

  def privacy_policy
  end
end
