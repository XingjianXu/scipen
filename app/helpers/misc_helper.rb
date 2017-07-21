module MiscHelper
  def active?(options)
    if options.is_a? String
      request.path.starts_with? options
    else
      r = false
      if options[:controller]
        r = params[:controller] == options[:controller]
      end
      if options[:action]
        r = r && params[:action] == options[:action]
      end
      r
    end
  end

  def active_class(options)
    active?(options) ? 'active' : ''
  end

  def empty_safe(e, empty_msg, &block)
    if e.present?
      capture(&block)
    else
      content_tag :div, content_tag(:p, empty_msg), class: 'empty-placeholder'
    end
  end
end
