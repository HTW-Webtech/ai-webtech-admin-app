module Email
  class ReviewDatesMailer
    attr_accessor :review_date

    def initialize(review_date:)
      @review_date = review_date
    end

    def subject
      "Neuer CodeReview-Termin am #{formatted_date}"
    end

    def message
      "Es wurde gerade für die #{exercise_id}te Aufgabe ein neuer CodeReview-Temin am #{formatted_date} eingetragen. Mehr Infos im Aris dazu."
    end

    def run
      users.each do |user|
        ApplicationMailer.sent_email(
          email: user.email,
          subject: subject,
          body: message,
        ).deliver_now!
      end
      Notifier.notify "Review-Date Email '#{subject}' verschickt an: #{users.map(&:email).join(', ')}"
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
