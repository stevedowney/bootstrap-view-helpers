# Helper methods for various Bootstrap dropdown menus
#
# * http://twitter.github.io/bootstrap/components.html#buttonDropdowns
# * http://twitter.github.io/bootstrap/components.html#navbar
#
# All of the *_dropdown methods should have dropdown_item() or dropdown_divider()
# as children.
#
#   = nav_dropdown('Admin') do
#     = dropdown_item('Users', admin_users_path)
#     = dropdown_item('Logs', admin_logs_path)
#     = dropdown_divider
#     = dropdown_item('Exceptions', admin_exceptions_path)
#
#   = button_dropdown('Actions') do
#     / dropdown_items
#
#   = split_button_dropdown('Edit', edit_user_path(@user)) do
#     / dropdown_items
#
module Bootstrap::DropdownHelper
  
  # should be nested within a <ul class='nav'> tag
  def nav_dropdown(text)
    content_tag(:li, class: 'dropdown') do
      nav_dropdown_link(text) + dropdown_ul { yield }
    end
  end
  
  # likely nested within button_toolbar
  def button_dropdown(*args)
    content_tag(:div, class: 'btn-group') do
      button_dropdown_link(*args) + dropdown_ul { yield }
    end
  end
  
  # likely nested within button_toolbar
  def split_button_dropdown(*args)
    extras = extract_extras(*args)
    
    content_tag(:div, class: 'btn-group') do
      split_button_dropdown_default(*args) + split_button_dropdown_toggle(extras) + dropdown_ul { yield }
    end
  end
  
  # Must be nested under one of the *_dropdown methods:
  #
  #  dropdown_item('Action', '/action')
  #  dropdown_item('Action')              # href set to 'javascript:void(0)'
  #  dropdown_item('Action', id: 'foo')   # options passed to <a> tag
  #
  def dropdown_item(*args)
    options = args.extract_options!
    text = args.shift or raise "Need text to link to"
    url = args.shift || js_void
    
    content_tag(:li) do
      link_to(text, url, options)
    end
  end
  
  # Produces a line to divide sections of a dropdown menu
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