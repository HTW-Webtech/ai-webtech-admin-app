module ApplicationHelper
  def announcements
    @announcements ||= []
  end

  def current_url(query:)
    uri = URI.parse(request.url)
    uri.query = query if query
    uri.to_s
  end

  def active_link_to_li(*args)
    additional = { wrap_tag: :li, active: :exclusive }
    opts = if args.last.is_a?(Hash)
      args.pop.merge(additional)
    else
      additional
    end
    args.push(opts)
    active_link_to(*args)
  end

  def app_status(app)
    if app.reloading?
      'Reloading'
    else
      'Ready'
    end
  end

  def app_status_class(app)
    if app.reloading?
      'danger'
    end
  end

  def app_tests_status(app)
    if app.achievable_exercise_points > 0
      "#{app.exercise_points} / #{app.achievable_exercise_points}"
    else
      "-"
    end
  end

  def app_tests_class(app)
    if app.tests_passed?
     'success'
    end
  end

  def app_review_status(app)
    if app.achievable_review_points > 0
      "#{app.review_points} / #{app.achievable_review_points}"
    else
      "-"
    end
  end

  def app_points(app)
    if app.achievable_total_points > 0
      "#{app.total_points} / #{app.achievable_total_points}"
    else
      "-"
    end
  end

  def link_to_back(record)
    if record.persisted?
      link_to 'Back', :back, class: 'btn btn-default'
    else
      link_to 'Cancel', :back, class: 'btn btn-default'
    end
  end
end
