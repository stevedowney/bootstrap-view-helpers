# See: http://twitter.github.io/bootstrap/components.html#labels-badges
# 
# Helper for producing Twitter Bootstrap labels.  We call them stamps because #label() is
# a Rails helper method.
#
# Default label:
#
#   stamp('Default')
#
# Other labels (see LABEL_TYPES):
#
#   stamp('Info', :info)
#
# Options passed through to <span> tag:
#
#   stamp('Warning', :warning, id: 'warn-id', class: 'more-class', my_key: 'my_value')
#
module Bootstrap::StampHelper
  InvalidStampTypeError = Class.new(StandardError)
  
  LABEL_TYPES = %w(default success warning important info inverse)
  
  # stamp('Text')
  # stamp('Text', :success)            # see LABEL_TYPES
  # stamp('Text', :info, id: 'my-id')  # options passed thru to <span>
  def stamp(*args)
    text = args.shift
    options = add_label_classes(*args)
    content_tag(:span, text, options)
  end

  private
  
  def add_label_classes(*args)
    options = args.extract_options!
    validate_label_types(args)
    classes = ['label'] + args.map { |arg| "label-#{arg}" }
    ensure_class(options, classes)
  end
  
  def validate_label_types(label_types)
    label_types.each { |e| raise(InvalidStampTypeError, e.inspect) unless LABEL_TYPES.include?(e.to_s) }
  end
  
end