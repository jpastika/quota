ActionMailer::Base.smtp_settings = {
  :address              => "mail.spokesystems.com",
  :port                 => "25",
  :domain               => "spokesystems.com",
  :user_name            => "jpastika@spokesystems.com",
  :password             => "eraew18",
  :authentication       => :login,
  :enable_starttls_auto => false
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?