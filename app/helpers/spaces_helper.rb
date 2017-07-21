module SpacesHelper
  def visibility_html_class(visibility)
    visibility = visibility.to_sym if visibility.is_a? String
    {
        personal: 'teal',
        trusted: 'green',
        unrestricted: 'purple'
    }[visibility]
  end
end
