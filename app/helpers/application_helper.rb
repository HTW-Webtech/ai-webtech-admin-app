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
end
