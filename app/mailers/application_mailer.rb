class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@taskmateapp.com"
  layout "mailer"
end
