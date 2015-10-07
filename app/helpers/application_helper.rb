module ApplicationHelper
  def active_link_to_li(*args)
    additional = { wrap_tag: :li, active: :exclusive }
    opts = if args.last.is_a?(Hash)
      args.pop.merge(additional)
    else
      additional
    end
    args.push(opts)
    active_link_to *args
  end

  def app_exercise_status(app)
    app.exercise_passed_at.present? ? "✓ +#{app.achievable_exercise_points} Points" : '⤫'
  end

  def app_review_icon(app)
    app.reviewed? ? "✓ +#{app.achievable_review_points} Points" : '⤫'
  end

  def app_points(app)
    "#{app.total_points} / #{app.achievable_total_points}"
  end

  def link_to_back(record)
    if record.persisted?
      link_to 'Back', :back, class: 'btn btn-default'
    else
      link_to 'Cancel', :back, class: 'btn btn-default'
    end
  end
end
