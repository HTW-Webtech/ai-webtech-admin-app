class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{cc(:site).hostname}"

  def sent_email(email:, subject:, body:)
    mail to: email, subject: subject, body: body, layout: 'email/base'
  end
end

