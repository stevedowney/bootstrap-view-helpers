module Bootstrap::AccordionHelper
  
  def accordion(options={})
    options = ensure_accordion_id(options)
    @accordion_id = options[:id]
    options = ensure_class(options, 'accordion')
    
    content_tag(:div, options) do
      yield
    end
  end
  
  def accordion_group(text, options={})
    options = ensure_accordion_group_id(options)
    @accordion_group_id = options[:id]
    open = options.delete(:open)
    
    content_tag(:div, class: 'accordion-group') do
      accordion_group_heading(text) + accordion_group_body(open) { yield }
    end
  end
  
  private
  
  def accordion_group_heading(text)
    content_tag(:div, class: 'accordion-heading') do
      content_tag(:a, text, class: %(accordion-toggle), href: "##{@accordion_group_id}", data: {toggle: 'collapse', parent: "##{@accordion_id}" })
    end
  end
  
  def accordion_group_body(open)
    classes = %w(accordion-body collapse)
    classes << 'in' if open
    
    content_tag(:div, id: @accordion_group_id, class: classes) do
      content_tag(:div, class: 'accordion-inner') do
        yield
      end
    end
  end
  
  def ensure_accordion_id(options)
    if options.has_key?(:id)
      options
    else
      @accordion_number = @accordion_number.to_i + 1
      options.dup.tap do |h|
        h[:id] = "accordion-#{@accordion_number}"
      end
    end
  end

  def ensure_accordion_group_id(options)
    if options.has_key?(:id)
      options
    else
      @accordion_group_number = @accordion_group_number.to_i + 1
      options.dup.tap do |h|
        h[:id] = "#{@accordion_id}-group-#{@accordion_group_number}"
      end
    end
  end
end