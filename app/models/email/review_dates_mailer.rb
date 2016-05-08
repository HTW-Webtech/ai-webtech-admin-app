module Email
  class ReviewDatesMailer
    attr_accessor :review_date

    def initialize(review_date:)
      @review_date = review_date
    end

    def run
      users.each do |user|
        ApplicationMailer.sent_email(
          email: user.email,
          bcc: 'igelmund@htw-berlin.de',
          subject: "Neuer CodeReview-Termin am #{formatted_date}",
          body: <<-MESSAGE.strip_heredoc
            Es wurde gerade für die #{exercise_id}te Aufgabe ein neuer CodeReview-Temin am #{formatted_date} eingetragen. Mehr Infos im Aris dazu.
          MESSAGE
        ).deliver_now!
      end
    end

    def users
      review_date.users
    end

    def exercise_id
      review_date.exercise_id
    end

    def formatted_date
      review_date.begins_at.to_s(:long)
    end
  end
end
