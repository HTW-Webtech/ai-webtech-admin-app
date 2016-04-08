module Email
  class Scheduler
    attr_accessor :group, :subject, :body

    def initialize(group:, subject:, body:)
      @group = group
      @subject = subject
      @body = body
    end

    def run
      group.users.map do |user|
        ApplicationMailer.sent_email(
          email: user.email,
          subject: subject,
          body: body,
        )
      end.all? { |mail| mail.deliver_now! }
    end
  end
end
