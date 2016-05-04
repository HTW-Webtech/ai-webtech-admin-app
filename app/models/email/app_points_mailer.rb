module Email
  class AppPointsMailer
    attr_accessor :app, :points

    def initialize(app:, points:)
      @app = app
      @points = points
    end

    def run
      ApplicationMailer.sent_email(
        email: app.user.email,
        subject: "#{points} Punkt(e) für App: #{app.permalink}",
        body: <<-MESSAGE.strip_heredoc
          Es wurden gerade für deine App #{app.permalink} #{points} Punkte im Aris eingetragen.
        MESSAGE
      ).deliver_now!
    end
  end
end
