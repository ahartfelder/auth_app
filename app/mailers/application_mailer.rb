class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@auth_app.com"
  layout "mailer"
end
