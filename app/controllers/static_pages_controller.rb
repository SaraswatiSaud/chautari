class StaticPagesController < ApplicationController
  def home
    session[:query] = params[:query] || session[:query]
    @stations = Station.active.distinct.joins(:streams).order(updated_at: :desc)
    @stations = @stations.where("name ILIKE '%#{session[:query]}%'") if session[:query].present?
    @stations = @stations.page(params[:page])
  end

  def contact
    # Send email if email params are present.
    if params[:from_name].present? && params[:from_email].present? && params[:text_part].present?
      begin
        @message = params.slice(:from_name, :from_email, :subject, :text_part).permit!
        ContactMailer.with(message: @message).contact_email.deliver_now!
        flash.now[:notice] = msg_success
        [:from_name, :from_email, :subject, :text_part].each { |key| params.delete(key) } if flash.now[:notice].present?
      rescue => e
        flash.now[:error] = msg_error
      end
    end
  end

  def about
  end

  def faq
  end

  def privacy_policy
  end

  private

  def msg_success
    "<h5>Message Sent</h5>Thank you for reaching out to us. We will get back to you if required.".html_safe
  end

  def msg_error
    "<h5>Error!</h5>Uh. Oh! something happened. Please check your values and retry again.".html_safe
  end
end
