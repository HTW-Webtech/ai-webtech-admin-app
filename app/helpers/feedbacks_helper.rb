module FeedbacksHelper
  EXERCISE_TEMPLATES = {
    8 => <<-EOF.strip_heredoc
    # Bewertung Abschlussprojekt: PatMan

    | Feature | Punkte: Erreicht/Von | Feedback |
    |----------------------------------------|
    | CRUD Patient | ?/3 | |
    |----------------------------------------|
    | CRUD Note    | ?/3 | |
    |----------------------------------------|
    | CRUD Appointment | ?/4 | |
    |----------------------------------------|
    | Statistiken | ?/2 | |
    |----------------------------------------|
    | Auflistung: Upcoming Appointments | ?/1 | |
    |----------------------------------------|
    | Auflistung: Past Appointments | ?/1 | |
    |----------------------------------------|
    | Auflistung: Notizen p. Patient | ?/1 | |
    |----------------------------------------|
    | Auflistung: Appointments p. Patient | ?/1 | |
    |----------------------------------------|
    | **Gesamtpunkte** | ?/16 | |
    |----------------------------------------|
    {: .table }
    EOF
  }
  def feedback_template(feedback)
    return feedback.body if feedback.body.present?
    EXERCISE_TEMPLATES.fetch(feedback.app.exercise_id, "Kein Template")
  end
end
