# SMTP settings for gmail
ActionMailer::Base.smtp_settings = {
 :address              => "smtp.gmail.com",
 :port                 => 587,
 :domain               => 'gmail.com',
 :user_name            => 'dctacademyblr@gmail.com',
 :password             => 'dct@Jayanagar430',
 :authentication       => "plain",
 :enable_starttls_auto => true,
 :openssl_verify_mode  => "none"
}