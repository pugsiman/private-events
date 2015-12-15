module ApplicationHelper
  def current_page(path)
    'current' if current_page?(path)

    # TODO: make it not buggy:
    # 'current' if request.url.include?(path)
  end

  # helper method following DRY principle. The string is the same
  # in both the hyperlink-text and the data-hover html attribute.
  def create_nav_link(string, path, method)
    link_to string, path, data: { hover: string }, method: method
  end

  # helper method following DRY principle using both mentioned methods.
  # consider that both nav_link and current_page methods are using the same
  # path variable.
  def create_nav_item(string, path, method = nil)
    content_tag :li, create_nav_link(string, path, method), class: current_page(path)
  end
end
