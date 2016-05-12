module Email
  class AppPointsMailer
    attr_accessor :app, :points

    def initialize(app:, points:)
      @app = app
      @points = points
    end

    def subject
      "#{points} Punkt(e) für App: #{app.permalink}"
    end

    def body
      "Es wurden gerade für deine App #{app.permalink} #{points} Punkte im Aris eingetragen."
    end

    def run
      ApplicationMailer.sent_email(
        email: app.user.email,
        subject: subject,
        body: body
      ).deliver_now!
    end
  end
end
