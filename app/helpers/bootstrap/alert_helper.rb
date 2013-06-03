# Rails helpers for producing Bootstrap alert boxes.
#
# See: http://twitter.github.io/bootstrap/components.html#alerts
# 
# @example
#   <%= alert('Default alert') %>
# 
#   <%= alert('Watch out!', :error) %>
#
#   <%= alert('This is the body', heading: 'Title') %>
#
#   <%= alert :success do %>
#     <%= alert_heading('A List') %>
#     <ul>
#       <li>One</li>
#       <li>Two</li>
#     </ul>
#   <% end %>
module Bootstrap::AlertHelper
  
  ALERT_ATTRIBUTES = %w(error success info block)
  
  # @overload alert(text, alert_type, options={})
  #   @param text [String] text of the label
  #   @param alert_type [Symbol, String] if present must be one of {Bootstrap::AlertHelper::ALERT_ATTRIBUTES}
  #   @param options [Hash] html attributes for returned alert <div>
  #   @option options [String] :heading if present, include a heading in the alert
  #   @option options [Boolean] :close if +false+, don't include a close link ('x')
  # @return [String] Returns html for alert
  def alert(*args, &block)
    text = args.shift unless block_given?
    options = canonicalize_options(args.extract_options!)
    options = ensure_class(options, 'alert')
    options = add_alert_classes(options, args)
    heading = options.delete(:heading)
    show_close = options.delete(:close) != false 
    
    if block_given?
      content_tag(:div, options) do
        alert_close(show_close) + 
        alert_heading(heading) + 
        capture(&block)
      end
    else
      content_tag(:div, options) do
        alert_close(show_close) + 
        alert_heading(heading) + 
        text
      end
    end
  end
  
  # Return an alert box close button
  #
  # @return [String] html for alert close button
  def alert_close(show=true)
    return '' unless show
    content_tag(:button, '&times;'.html_safe, class: 'close', data: {dismiss: 'alert'})
  end

  # Return an alert heading
  #
  # @return [String] html for alert heading
  def alert_heading(heading)
    return '' unless heading.present?
    content_tag(:h4, heading)
  end
  
  private
  
  def add_alert_classes(options, alert_attributes)
    validate_alert_attributes(alert_attributes)
    classes = ['alert'] + alert_attributes.map { |e| "alert-#{e}" }
    ensure_class(options, classes)
  end
  
  def validate_alert_attributes(alert_attributes)
    alert_attributes.each { |e| raise(InvalidAlertAttributeError, e.inspect) unless ALERT_ATTRIBUTES.include?(e.to_s) }
  end
  
  
end