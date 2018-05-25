class StaticPagesController < ApplicationController
  def home
    session[:query] = params[:query] || session[:query]
    @stations = Station.distinct.joins(:streams).order(id: :desc)
    @stations = @stations.where("name ILIKE '%#{session[:query]}%'") if session[:query].present?
    @stations = @stations.page(params[:page])
  end

  def contact
    @title = 'Contact'
  end

  def about
    @title = 'About Us'
  end

  def faq
    @title = 'Frequently Asked Questions'
  end

  def privacy_policy
    @title = 'Privacy Policy'
  end
end
