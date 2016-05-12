module Email
  class CodeReviewConfirmationMailer
    attr_accessor :review_date

    def initialize(review_date)
      @review_date = review_date
    end

    def subject
      "#{review_date.review_points} Punkt(e) für Code Review zur Aufgabe #{review_date.exercise_id}"
    end

    def body
      "Zu deinem CodeReview-Termin vom #{review_date.formatted_begins_at} zur Aufgabe #{review_date.exercise_id} wurden dir #{review_date.review_points} Punkte im Aris eingetragen."
    end

    def run
      review_date.users.each do |user|
        ApplicationMailer.sent_email(
          email: user.email,
          subject: subject,
          body: body
        ).deliver_now!
      end
    end
  end
end
