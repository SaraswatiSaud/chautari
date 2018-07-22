class StaticPagesController < ApplicationController
  def home
    session[:query] = params[:query] || session[:query]
    @stations = Station.active.distinct.joins(:streams).order(updated_at: :desc)
    @stations = @stations.where("name ILIKE '%#{session[:query]}%'") if session[:query].present?
    @stations = @stations.page(params[:page])
  end

  def contact
    if params[:name].present? && params[:email].present? && params[:message].present?
      c = ContactForm.new(params.slice(:name, :email, :subject, :message, :nickname))
      unless c.valid? && c.deliver
        flash.now[:error] = "<h5>Following error(s) occurred:</h5>#{c.errors.full_messages.join(', ')}.".html_safe
      else
        flash.now[:notice] = "<h5>Message Sent</h5>Thank you for reaching out to us. We will get back to you if required.".html_safe
        [:name, :email, :subject, :message].each { |key| params.delete(key) } if flash.now[:notice].present?
      end
    end
  end

  def about
  end

  def faq
  end

  def privacy_policy
  end
end
