# Rails helper methods associated with forms for Bootstrap.
#
# @example +#submit_button_tag()+ instead of +#submit_button()+
#   submit_button_tag
#   submit_button_tag('Save')
#   submit_button_tag('Delete', :danger)
#   submit_button_tag('Big', :large)
#   submit_button_tag('With Options', :small, :info, id: 'my-id')
module Bootstrap::FormHelper
  InvalidButtonModifierError = Class.new(StandardError)
  
  # Returns <input> similar to +#submit_tag()+ but:
  # * styled like a Bootstrap button, type :primary
  # * has +:disable_with+ set to "Processing ..."
  # See {Bootstrap::ButtonHelper} for documentation on button type and size
  # @overload submit_button_tag(options={})
  #   @param [Hash] options all options except +:disable_with+ become html attributes for <input> tag
  #   @option options [String, false] :disable_with either override or turn off the disabling of the button
  # @overload submit_button_tag(text, options={})
  #   @param [String] text value of <input>
  #   @param [Hash] options see +options+ param in first method signature
  # @overload submit_button_tag(text, type, options={})
  #   @param [String] text value of <input>
  #   @param [String, Symbol] type type of button
  #   @param [Hash] options see +options+ param in first method signature
  # @overload submit_button_tag(text, size, options={})
  #   @param [String] text value of <input>
  #   @param [String, Symbol] size size of button
  #   @param [Hash] options see +options+ param in first method signature
  # @overload submit_button_tag(text, type, size, options={})
  #   @param [String] text value of <input>
  #   @param [String, Symbol] type type of button
  #   @param [String, Symbol] size size of button
  #   @param [Hash] options see +options+ param in first method signature
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