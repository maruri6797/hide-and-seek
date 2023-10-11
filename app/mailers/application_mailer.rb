class ApplicationMailer < ActionMailer::Base
  default from: ENV['MY_MAIL_ADDRESS']
  layout 'mailer'
end
