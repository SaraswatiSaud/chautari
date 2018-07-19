class StaticPagesController < ApplicationController
  def home
    session[:query] = params[:query] || session[:query]
    @stations = Station.active.distinct.joins(:streams).order(updated_at: :desc)
    @stations = @stations.where("name ILIKE '%#{session[:query]}%'") if session[:query].present?
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
