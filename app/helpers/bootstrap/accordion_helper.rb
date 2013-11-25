# Rails helpers for building Bootstrap accordions.
#
# See: http://twitter.github.io/bootstrap/javascript.html#collapse
#
#   <%= accordion do %>
#
#     <%= accordion_group('Section 1', open: true) do %>
#       content for group 1
#     <% end >
#
#     <%= accordion_group('Section 1') do %>
#       content for group 2
#     <% end %>
#
#   <% end %>
#
module Bootstrap::AccordionHelper
  
  # Returns the html for a Bootstrap accordion.
  #
  # @param [Hash] options html attributes for accordion <div>
  # @return [String] <div class="accordion"> plus results of yielded block
  # @yield Should contain calls to {Bootstrap::AccordionHelper#accordion_group}
  # @yieldreturn [String] Html from {Bootstrap::AccordionHelper#accordion_group} calls
  def accordion(options={})
    options = canonicalize_options(options)
    options = ensure_accordion_id(options)
    @accordion_id = options[:id]
    options = ensure_class(options, 'accordion')
    
    content_tag(:div, options) do
      yield
    end
  end
  
  # Returns the html for a Bootstrap accordion group.
  # 
  # @param [String] text the text in the accordion group header
  # @param [Hash] options All keys except +:open+ become html attributes for the accordion group
  # @option options [true] :open Set to +true+ if you want this group initially open
  # @option options [true] :parent Set to +false+ if you want to enable multiple groups to be open at the same time
  # @yield Html contents of accordion group
  # @yieldreturn [String] Html for accordion group contents
  def accordion_group(text, options={})
    options = canonicalize_options(options)
    open = options.delete(:open)
    parent = options.delete(:parent)

    # options = ensure_accordion_group_id(options)
    @accordion_group_id = get_next_group_id

    options = ensure_class(options, 'accordion-group')

    content_tag(:div, options) do
      accordion_group_heading(text, parent) + accordion_group_body(open) { yield }
    end
  end
  
  private

  def accordion_group_heading(text, parent)
    selector = parent == false ? nil : @accordion_id
    content_tag(:div, class: 'accordion-heading') do
      content_tag(:a, text, class: %(accordion-toggle), href: "##{@accordion_group_id}",
                  data: {toggle: 'collapse', parent: "##{selector}" })
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
    @accordion_group_number = 0
    
    if options.has_key?(:id)
      options
    else
      @accordion_number = @accordion_number.to_i + 1
      options.dup.tap do |h|
        h[:id] = "accordion-#{@accordion_number}"
      end
    end
  end

  def get_next_group_id
    @accordion_group_number = @accordion_group_number + 1
    "#{@accordion_id}-group-#{@accordion_group_number}"
  end

  # def ensure_accordion_group_id(options)
  #   if options.has_key?(:id)
  #     options
  #   else
  #     @accordion_group_number = @accordion_group_number.to_i + 1
  #     options.dup.tap do |h|
  #       h[:id] = "#{@accordion_id}-group-#{@accordion_group_number}"
  #     end
  #   end
  # end
end