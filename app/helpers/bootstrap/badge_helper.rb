# See: http://twitter.github.io/bootstrap/components.html#labels-badges
# 
# Helper for producing Twitter Bootstrap badges
#
# Default badge:
#
#   badge('Default')
#
# Other badges (see BADGE_TYPES):
#
#   badge('Info', :info)
#
# Options passed through to <span> tag:
#
#   badge('Warning', :warning, id: 'warn-id', class: 'more-class', my_key: 'my_value')
#
module Bootstrap::BadgeHelper
  InvalidBadgeTypeError = Class.new(StandardError)
  
  BADGE_TYPES = %w(default success warning important info inverse)
  
  def badge(*args)
    text = args.shift
    options = add_badge_classes(*args)
    content_tag(:span, text, options)
  end

  private
  
  def add_badge_classes(*args)
    options = args.extract_options!
    validate_badge_types(args)
    classes = ['badge'] + args.map { |arg| "badge-#{arg}" }
    ensure_class(options, classes)
  end
  
  def validate_badge_types(badge_types)
    badge_types.each { |e| raise(InvalidBadgeTypeError, e.inspect) unless BADGE_TYPES.include?(e.to_s) }
  end
  
end