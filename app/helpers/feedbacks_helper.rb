module FeedbacksHelper
  EXERCISE_TEMPLATES = {
    8 => <<-EOF.strip_heredoc
    # Bewertung Abschlussprojekt

    | Feature | Punkte | Erreicht | Feedback |
    |----------------------------------------|
    | CRUD Projekte | 3 | ? | |
    |----------------------------------------|
    | CRUD Arbeitszeiten | 3 | ? | |
    |----------------------------------------|
    | CRUD Rechnungen | 4 | ? | |
    |----------------------------------------|
    | Statistiken | 3 | ? | |
    |----------------------------------------|
    | Druck-Vorschau | 1 | ? | |
    |----------------------------------------|
    | Berechnung MwST/Netto | 2 | ? | |
    |----------------------------------------|
    | **Gesamtpunkte** | ?  |
    |----------------------------------------|
    {: .table }
    EOF
  }
  def feedback_template(feedback)
    return feedback.body if feedback.body.present?
    EXERCISE_TEMPLATES.fetch(feedback.app.exercise_id, "Kein Template")
  end
end
