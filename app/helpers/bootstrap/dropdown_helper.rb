# Rails helper methods for various Bootstrap dropdown menus
#
# * http://twitter.github.io/bootstrap/components.html#buttonDropdowns
# * http://twitter.github.io/bootstrap/components.html#navbar
#
# @example nav dropdown
#  <%= nav_dropdown('Admin') do %>
#    <%= dropdown_item('Users', '/admin/users') %>
#    <%= dropdown_item('Logs', '/admin/logs') %>
#    <%= dropdown_divider %>
#    <%= dropdown_item('Exceptions', '/admin/exceptions') %>
#  <% end %>
#
# @example button dropdown
#  <%= button_dropdown('Actions') do %>
#    <%= dropdown_item('Action 1', '/action1') %>
#    <%= dropdown_item('Action 2', '/action2') %>
#  <% end %>
#
# @example split-button dropdown
#   <%= split_button_dropdown('Default', url: '/default') do %>
#     <%= dropdown_item('Action 1', '/action1') %>
#     <%= dropdown_item('Action 2', '/action2') %>
#   <% end %>#
#
module Bootstrap::DropdownHelper
  
  # Returns a drop-down menu of links
  #
  # Usually called from yielded block of {Bootstrap::NavHelper#nav_bar}
  #
  # @param [String] text text of dropdown link
  # @yield yielded block is usually calls to {Bootstrap::NavHelper#dropdown_item} or {Bootstrap::NavHelper#dropdown_divider}
  # @return [String] '<li class='dropdown'><ul class='dropdown-menu'> with contents of yielded block
  def nav_dropdown(text, options={})
    options = canonicalize_options(options)
    options = ensure_class(options, 'dropdown')
    
    content_tag(:li, options) do
      nav_dropdown_link(text) + dropdown_ul { yield }
    end
  end
  
  # Returns a Bootstrap button dropdown
  #
  # Parameters have same semantics as in {Bootstrap::ButtonHelper#button}
  #
  # @overload button_dropdown('Text')
  # @overload button_dropdown('Text', :info)
  # @overload button_dropdown('Text', :info, :mini)
  # @yield yielded block is usually calls to {Bootstrap::NavHelper#dropdown_item} or {Bootstrap::NavHelper#dropdown_divider}# @return [String]
  def button_dropdown(*args)
    content_tag(:div, class: 'btn-group') do
      button_dropdown_link(*args) + dropdown_ul { yield }
    end
  end
  
  # Returns a Bootstrap split-button dropdown
  # 
  # Parameters have same semantics as in {Bootstrap::ButtonHelper#button}
  # 
  # @overload split_button_dropdown('Text')
  # @overload split_button_dropdown('Text', url: '/url')
  # @overload split_button_dropdown('Text', :large, :danger, url: '/url')
  # @yield yielded block is usually calls to {Bootstrap::NavHelper#dropdown_item} or {Bootstrap::NavHelper#dropdown_divider} 
  # @return [String]
  def split_button_dropdown(*args)
    extras = extract_extras(*args)
    
    content_tag(:div, class: 'btn-group') do
      split_button_dropdown_default(*args) + split_button_dropdown_toggle(extras) + dropdown_ul { yield }
    end
  end
  
  # Returns a link for use within various *_dropdown methods
  #
  # @overload dropdown_item('Text')
  # @overload dropdown_item('Text', url: '/url')
  # @return [String]
  def dropdown_item(*args)
    options = args.extract_options!
    text = args.shift or raise "Need text to link to"
    url = args.shift || 'javascript:void(0)'
    
    content_tag(:li) do
      link_to(text, url, options)
    end
  end
  
  # Returns a divider for various dropdowns
  # @return [String] <li class="divider">
  def dropdown_divider
    content_tag(:li, nil, class: 'divider')
  end

  private
  
  def nav_dropdown_link(text)
    content_tag(:a, class: "dropdown-toggle", data: {toggle: "dropdown"}, href: "#") do
      safe_join( [ h(text), caret ], ' ' )
    end    
  end

  def button_dropdown_link(*args)
    text = args.shift
    classes = %w(btn dropdown-toggle) + args.map { |e| "btn-#{e}" }
    content_tag(:a, class: classes, data: {toggle: "dropdown"}, href: "#") do
      safe_join( [ h(text), caret ], ' ' )
    end
  end
  
  def split_button_dropdown_default(*args)
    button(*args)
  end
  
  def split_button_dropdown_toggle(extras)
    classes = %w(btn dropdown-toggle) + extras.map { |e| "btn-#{e}" }
    content_tag(:button, class: classes, data: {toggle: 'dropdown'}) do
      caret
    end
  end
  
  def dropdown_ul
    content_tag(:ul, class: "dropdown-menu") do
      yield
    end
  end
  
end