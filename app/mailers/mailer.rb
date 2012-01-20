class Mailer < ActionMailer::Base
  default :to => APP_CONFIG[:contact_email]

  def inquiry(message)
    @message = message
    mail(:reply_to => message.email, :subject => "#{message.name} sent you a message from #{APP_CONFIG[:app_name]}.")
  end
end
