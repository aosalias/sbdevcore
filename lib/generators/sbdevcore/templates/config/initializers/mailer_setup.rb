ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "sbdev.heroku.com",
  :user_name            => "aosalias",
  :password             => "nunnery85",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options[:host] = "localhost:3000"  