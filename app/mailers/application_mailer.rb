class ApplicationMailer < ActionMailer::Base
  default from: "#{ENV['CONTACT_FROM_NAME']} <#{ENV['DEFAULT_EMAIL']}>"
  layout 'mailer'
end
