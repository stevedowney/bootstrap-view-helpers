# Rails helper for producing Twitter Bootstrap labels.  We use +#stamp()+ because +#label()+ is
# a standard Rails helper method.
#
# See: http://twitter.github.io/bootstrap/components.html#labels-badges
# 
# @example
#   stamp('Default')
#   stamp('Info', :info)  
#   stamp('Warning', :warning, id: 'warn-id', class: 'more-class', my_key: 'my_value')
#
module Bootstrap::StampHelper
  InvalidStampTypeError = Class.new(StandardError)
  
  LABEL_TYPES = %w(default success warning important info inverse)

  #=> see {Bootstrap::StampHelper::LABEL_TYPES}

  # Returns a Bootstrap label
  #
  # @overload stamp(text, options={})
  #   Returns a label of type :default
  #   @param [String] text text of the label
  #   @param [Hash] options html attributes for returned <span>
  # @overload stamp(text, type, options={})
  #   Returns a label of type _type_
  #   @param [String] text text of the label
  #   @param [Symbol, String] type type of label see {Bootstrap::StampHelper::LABEL_TYPES}
  #   @param [Hash] options html attributes for returned <span>
  # @return [String]
  def stamp(*args)
    text = args.shift
    options = add_label_classes(*args)
    content_tag(:span, text, options)
  end

  private
  
  def add_label_classes(*args)
    options = canonicalize_options(args.extract_options!)
    validate_label_types(args)
    classes = ['label'] + args.map { |arg| "label-#{arg}" }
    ensure_class(options, classes)
  end
  
  def validate_label_types(label_types)
    label_types.each { |e| raise(InvalidStampTypeError, e.inspect) unless LABEL_TYPES.include?(e.to_s) }
  end
  
end