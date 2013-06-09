# Rails helper methods associated with forms for Bootstrap.
#
# @example Bootstrap form-actions <div>
#   <%= form_actions do %>
#     <%= submit_button_tag %>
#     <%= cancel_button_tag %>
#   <% end %>
#
module Bootstrap::FormHelper
  ArgumentError = Class.new(StandardError)
  InvalidButtonModifierError = Class.new(StandardError)
  
  # Convenience method for standard "Cancel" button.
  #
  # The +text, type,+ and +size+ arguments are all optional.
  #
  # Has same semantics as calls to {Bootstrap::ButtonHelper#button} except:
  # * text defaults to "Cancel"
  # * +:url+ option is required
  # @example
  #   cancel_button_tag(url: '/')
  #   cancel_button_tag('Go Back', url: '/')
  #   cancel_button_tag(:info, url: '/')
  #   cancel_button_tag(:large, url: '/')
  #   cancel_button_tag('Return', :small, :warning, url: '/', id: 'my-id')
  # @overload cancel_button_tag(text, type, size, options={})
  #   @param [String] text text of link
  #   @param [Symbol] type type of button
  #   @param [Symbol] size size of button
  #   @param [Hash] options All keys except +:url+ become html attributes of the <a> tag
  #   @option options [String] :url required
  # @return [String] <a> tag styled as Bootstrap button
  def cancel_button_tag(*args)
    options = canonicalize_options(args.extract_options!)
    raise(ArgumentError, "must pass a :url option") unless options.has_key?(:url)
    options = ensure_class(options, 'btn')
    
    args.map!(&:to_s)
    args.unshift("Cancel") if args.all? { |e| ::Bootstrap::ButtonHelper::BUTTON_ALL.include?(e) }

    button(*args, options)
  end
  
  # Convience method for Bootstrap form action DIV.
  #
  # @param options [Hash] options become html attributes of returned <div>
  # @return [String] <div> with yielded block
  def form_actions(options={})
    options = canonicalize_options(options)
    options = ensure_class(options, 'form-actions')
    
    content_tag(:div, options) do
      yield
    end
  end
  
  # Returns <input> similar to +#submit_tag()+ but:  x
  # * styled like a Bootstrap button, type :primary
  # * has +:disable_with+ set to "Processing ..."
  # See {Bootstrap::ButtonHelper} for documentation on button type and size
  #   submit_button_tag('Save')
  #   submit_button_tag('Delete', :danger)
  #   submit_button_tag('Big', :large)
  #   submit_button_tag('With Options', :small, :info, id: 'my-id')
  # @overload submit_button_tag(text, type, size, options={})
  #   @param [String] text value of <input>
  #   @param [String, Symbol] type type of button
  #   @param [String, Symbol] size size of button
  #   @param [Hash] options all options except +:disable_with+ become html attributes for <input> tag
  #   @option options [String, false] :disable_with either override or turn off the disabling of the button
  # @return [String]
  def submit_button_tag(*args)
    options = canonicalize_options(args.extract_options!)
    
    value = if Bootstrap::ButtonHelper::BUTTON_ALL.include?(args.first.to_s)
      "Save changes"
    else
      args.shift.presence || "Save changes"
    end

    button_classes = if args.present?
      args.each { |e| raise(InvalidButtonModifierError, e.inspect) unless
         Bootstrap::ButtonHelper::BUTTON_ALL.include?(e.to_s) }
      ['btn'] + args.map { |e| "btn-#{e}" }
    else
      ['btn', 'btn-primary']
    end
    options = ensure_class(options, button_classes)

    options[:disable_with] = "Processing ..." unless options.has_key?(:disable_with)

    submit_tag(value, options)
  end
  
end