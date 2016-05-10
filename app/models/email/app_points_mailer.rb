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

    def message
      "Es wurden gerade für deine App #{app.permalink} #{points} Punkte im Aris eingetragen."
    end

    def run
      ApplicationMailer.sent_email(
        email: app.user.email,
        subject: subject,
        body: message
      ).deliver_now!
      Notifier.notify subject
    end
  end
end
