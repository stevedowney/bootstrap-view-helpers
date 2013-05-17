module Bootstrap::FormHelper
  
  def submit_tag(value = "Save changes", options = {})
    options = arrayify_class(options.symbolize_keys)
    
    class_arg = Array(options.delete(:class)).map(&:to_s)
    classes = []
    classes << 'btn-primary' unless options.delete(:bootstrap) == false ||
       class_arg.detect { |e| e.starts_with?('btn-') }
    class_arg.each { |e| classes << e }
    classes << 'btn' if classes.detect { |e| e.starts_with?('btn-') }
    options = ensure_class(options, classes)
    
    options[:disable_with] = "Processing ..." unless options.has_key?(:disable_with)

    super(value, options)
  end
  
end