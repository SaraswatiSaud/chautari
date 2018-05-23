class StaticPagesController < ApplicationController
  def home
    @stations = Station.distinct.joins(:streams).order(id: :desc)
    @stations = @stations.where("name ILIKE '%#{params[:query]}%'") if params[:query].present?
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
