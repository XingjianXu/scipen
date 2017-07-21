module BreadcrumbHelper
  def compute_name(element)
    case name = element.name
    when Symbol
      send(name)
    when Proc
      name.call(self)
    else
      name.to_s
    end
  end

  def compute_path(element)
    case path = element.path
    when Symbol
      send(path)
    when Proc
      path.call(self)
    else
      url_for(path)
    end
  end
end
