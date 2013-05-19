# @private
class Bootstrap::IconRenderer
  ArgumentError = Class.new(StandardError)
  
  delegate :canonicalize_options, :content_tag, :ensure_class, :h, to: :template
  attr_accessor :template, :options, :args, :text
  
  def initialize(template, *args)
    self.template = template
    process_arguments(args)
  end
  
  def html
    icon_tag.tap do |tag|
      tag << text if text.present?
    end
  end
  
  private
  
  def icon_tag
    content_tag(:i, nil, options)
  end
  
  def process_arguments(args)
    self.options = canonicalize_options(args.extract_options!)
    self.args = args.map { |e| e.to_s }

    process_icon_type
    process_icon_white
    process_text
  end
  
  def process_icon_type
    icon_type = args.shift.presence or raise(ArgumentError, "must pass an icon type")
    icon_class = icon_type == 'blank' ? 'icon-search' : "icon-#{icon_type}"
    self.options = ensure_class(self.options, icon_class)
    
    if icon_type == 'blank'
      options[:style] = [options[:style], 'opacity: 0'].map(&:presence).compact.join('; ')
    end
  end
  
  def process_icon_white
    if args.delete('white')
      self.options = ensure_class(options, "icon-white")
    end
  end

  def process_text
    self.text = if args.size == 0
      nil
    elsif args.size == 1
      h(" #{args.first}")
    else
      raise ArgumentError, 'too many arguments'
    end 
  end

end