# Helper for producing Twitter Bootstrap buttons OR links that look like buttons.
# See: http://twitter.github.io/bootstrap/base-css.html#buttons
#
# Default button:
#
#   button('Default') #=> <button class="btn">Default</button>
#
# Pass in a url to make a link that looks like a button:
#
#   button('Home', url: '/home')    #=> <a href="/home" class="btn">Home</a>
#
# Or make a <button> look like a link:
#
#   button('Home', :link)
#
# Specify the type (see BUTTON_TYPES):
#
#   button('Info', :info)
#
# Specify the size (see BUTTON_SIZES)
#
#   button('Small', :small)
#
# Options passed through to <span> tag:
#
#   button('Warning', :warning, :large id: 'warn-id', class: 'more-class', my_key: 'my_value')
#
# Button groups/toolbars: http://twitter.github.io/bootstrap/components.html#buttonGroups
#
#   = button_group do
#     = button("Left", "/left")
#     = button("Right", "/right")
#
#   = button_toolbar do
#     = button('Single Button', '/single')
#     = button_group
#       = button('Group Button 1')
#       = button('Group Button 2')
#     = button('Another Single')
#
module Bootstrap::ButtonHelper
  InvalidButtonModifierError = Class.new(StandardError)

  BUTTON_TYPES = %w(default primary info success warning danger inverse link)
  BUTTON_SIZES = %w(default large small mini)
  BUTTON_OTHERS = %w(block)
  
  BUTTON_ALL = BUTTON_TYPES + BUTTON_SIZES + BUTTON_OTHERS
  
  def button(*args)
    text = args.shift
    options = args.extract_options!
    href = options.delete(:url)
    options = add_button_classes(options, args)

    if href.present?
      link_to(text, href, options)
    else
      content_tag(:button, text, options)
    end
  end
    
  def button_toolbar
    content_tag(:div, class: 'btn-toolbar') do
      yield
    end
  end
  
  def button_group
    content_tag(:div, class: 'btn-group') do
      yield
    end
  end
    
  private
  
  def add_button_classes(options, button_types_and_sizes)
    validate_types_and_sizes(button_types_and_sizes)
    classes = ['btn'] + button_types_and_sizes.map { |e| "btn-#{e}" }
    ensure_class(options, classes)
  end
  
  def validate_types_and_sizes(types_and_sizes)
    types_and_sizes.each { |e| raise(InvalidButtonModifierError, e.inspect) unless BUTTON_ALL.include?(e.to_s) }
  end
  
end