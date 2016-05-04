class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{cc(:site).hostname}"

  def sent_email(email:, subject:, body:, bcc: 'igelmund@htw-berlin.de')
    mail to: email, bcc: bcc, subject: subject, body: body, layout: 'email/base'
  end
end

