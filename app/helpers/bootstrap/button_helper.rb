# Helper for producing Twitter Bootstrap buttons OR links that look like buttons.
#
# See:
# * http://twitter.github.io/bootstrap/base-css.html#buttons
# * http://twitter.github.io/bootstrap/components.html#buttonGroups
# * http://twitter.github.io/bootstrap/components.html#buttonDropdowns
# @example Button / Link
#
#   # button
#   button('Default')
#
#   # add url option to make <a> styled as button
#   button('Home', url: '/')
#
#   # a button styled as a link
#   button('Home', :link)
#
#   # give it a type; see BUTTON_TYPES
#   button('Info', :info)
#
#   # give it a size (see BUTTON_SIZES)
#   button('Small', :small)
#
#   # size, type, additional class and additional html attributes
#   button('Warning', :warning, :large, id: 'warn-id', class: 'more-class', my_key: 'my_value')
#
# @example Button Group
#   <%= button_group do %>
#     <%= button("Left", url: "/left") %>
#     <%= button("Right", id: 'right') %>
#   <% end %>
#
# @example Button Toolbar
#    <%= button_toolbar do %>
#      <%= button('Single Button', url: '/single') %>
#      <%= button_group do %>
#        <%= button('Group Button 1') %>
#        <%= button('Group Button 2') %>
#      <% end %>
#      <%= button('Another Single') %>
#   <% end %>
module Bootstrap::ButtonHelper
  InvalidButtonModifierError = Class.new(StandardError)

  BUTTON_TYPES = %w(default primary info success warning danger inverse link)
  BUTTON_SIZES = %w(default large small mini)
  BUTTON_OTHERS = %w(block)
  
  BUTTON_ALL = BUTTON_TYPES + BUTTON_SIZES + BUTTON_OTHERS
  
  # Returns <button> or <a> styled as Bootstrap button
  #
  # @overload button(text, options={})
  #   Default button
  #   @param [String] text text of button
  #   @param [Hash] options All keys except +:url+ become html attributes for the generated tag
  #   @option options [String] :url if present, return a <a> styled as a button
  # @overload button(text, type, options={})
  #   Button of type _type_
  #   @param [String] text text of button
  #   @param [String, Symbol] type type of button; see {Bootstrap::ButtonHelper::BUTTON_TYPES}
  #   @param [Hash] options All keys except +:url+ become html attributes for the generated tag
  #   @option options [String] :url if present, return a <a> styled as a button
  # @overload button(text, size, options={})
  #   Button of size _size_
  #   @param [String] text text of button
  #   @param [String, Symbol] size size of button; see {Bootstrap::ButtonHelper::BUTTON_SIZES}
  #   @param [Hash] options All keys except +:url+ become html attributes for the generated tag
  #   @option options [String] :url if present, return a <a> styled as a button
  # @overload button(text, type, size, options={})
  #   Button of type _type_, size _size_
  #   @param [String] text text of button
  #   @param [String, Symbol] type type of button; see {Bootstrap::ButtonHelper::BUTTON_TYPES}
  #   @param [String, Symbol] size size of button; see {Bootstrap::ButtonHelper::BUTTON_SIZES}
  #   @param [Hash] options All keys except +:url+ become html attributes for the generated tag
  #   @option options [String] :url if present, return a <a> styled as a button
  # @return [String] Html for a <button> (or <a> if +url+ option passed in)
  def button(*args)
    text = args.shift
    options = canonicalize_options(args.extract_options!)
    href = options.delete(:url)
    options = add_button_classes(options, args)

    if href.present?
      link_to(text, href, options)
    else
      content_tag(:button, text, options)
    end
  end
    
  # Returns a Bootstrap button toolbar
  #
  # @param [Hash] options will be come html attributes of generated <div>
  # @yield block usually consists of calls to {Bootstrap::ButtonHelper#button} or {Bootstrap::ButtonHelper#button_group}
  # @yieldreturn [String] html for contents of toolbar
  #
  # @return [String] html for button toolbar
  def button_toolbar(options={})
    options = canonicalize_options(options)
    options = ensure_class(options, 'btn-toolbar')
    
    content_tag(:div, options) do
      yield
    end
  end
  
  # Returns a Bootstrap button group
  #
  # @param [Hash] options will be come html attributes of generated <div>
  # @yield block usually consists of calls to {Bootstrap::ButtonHelper#button}
  # @yieldreturn [String] html for contents of group
  #
  # @return [String] html for button group
  def button_group(options={})
    options = canonicalize_options(options)
    options = ensure_class(options, 'btn-group')
    
    content_tag(:div, options) do
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