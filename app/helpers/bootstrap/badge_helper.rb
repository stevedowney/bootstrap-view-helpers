# Rails helper for producing Twitter Bootstrap badges
#
# See: http://twitter.github.io/bootstrap/components.html#labels-badges
# 
# Default badge:
#
# @example
#   badge('Default')
#
#   badge('Info', :info)
#
#   badge('Warning', :warning, id: 'warn-id', class: 'more-class', my_key: 'my_value')
#
module Bootstrap::BadgeHelper
  InvalidBadgeTypeError = Class.new(StandardError)
  
  BADGE_TYPES = %w(default success warning important info inverse)
  
  # Returns html for a Bootstrap badge.
  #
  # @overload badge(text, options={})
  #   Returns html for +default+ badge
  #   @param [String] text Text of badge
  #   @param [Hash] options Html attributes for badge <span>
  # @overload badge(text, badge_type, options={})
  #   Returns html for badge of type _badge_type_
  #   @param [String] text Text of badge
  #   @param [String, Symbol] badge_type one of BADGE_TYPES
  #   @param [Hash] options Html attributes for badge <span>
  # @return [String] html for badge
  # @raise [InvalidBadgeTypeError] When a badge type is passed and isn't one of the BADGE_TYPES
  def badge(*args)
    text = args.shift
    options = add_badge_classes(*args)
    content_tag(:span, text, options)
  end

  private
  
  def add_badge_classes(*args)
    options = canonicalize_options(args.extract_options!)
    validate_badge_types(args)
    classes = ['badge'] + args.map { |arg| "badge-#{arg}" }
    ensure_class(options, classes)
  end
  
  def validate_badge_types(badge_types)
    badge_types.each { |e| raise(InvalidBadgeTypeError, e.inspect) unless BADGE_TYPES.include?(e.to_s) }
  end
  
end