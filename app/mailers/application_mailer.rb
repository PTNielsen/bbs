class ApplicationMailer < ActionMailer::Base
  default from: "admin@bbs.com"

  layout 'mailer'
end