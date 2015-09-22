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

  def app_status_info(app)
    '✓'
  end

  def link_to_back(record)
    if record.persisted?
      link_to 'Back', :back, class: 'btn btn-default'
    else
      link_to 'Cancel', :back, class: 'btn btn-default'
    end
  end
end
