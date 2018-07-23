class ContactMailer < ApplicationMailer
  def contact_email
    @message = params[:message]
    mail to: ENV['FEEDBACKS_EMAIL'], subject: ENV['CONTACT_EMAIL_SUBJECT']
  end
end
