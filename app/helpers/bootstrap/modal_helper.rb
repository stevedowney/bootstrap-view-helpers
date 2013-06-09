# Rails helper for producing Bootstrap modal dialogs
#
module Bootstrap::ModalHelper

  # Returns an A tag to trigger (open) a Boostrap modal
  def modal_trigger(text, options={})
    options = canonicalize_options(options)
    href = options.delete(:href) or raise(ArgumentError, 'missing :href option')
    options.merge!(role: 'button', href: href, data: { toggle: 'modal'})
    options = ensure_class(options, 'btn')
    
    content_tag(:a, text, options)
  end

  # Returns a Bootstrap modal dialog
  def modal(options={})
    options = canonicalize_options(options)
    options.has_key?(:id) or raise(ArgumentError, "missing :id option")
    options = ensure_class(options, %w(modal hide fade))
    options.merge!(tabindex: "-1", role: "dialog")
    
    content_tag(:div, options) do
      yield
    end
  end
  
  # Returns a DIV for Bootstrap modal header
  def modal_header(*args, &block)
    options = canonicalize_options(args.extract_options!)
    options = ensure_class(options, 'modal-header')
    show_close = options.delete(:close) != false
  
    content = block_given? ? capture(&block) : args.shift
  
    content_tag(:div, options) do
      modal_header_close_button(show_close) +
      content_tag(:h3) do
        content
      end
    end
  end

  # Returns a DIV for Bootstrap modal body
  def modal_body(*args, &block)
    options = canonicalize_options(args.extract_options!)
    options = ensure_class(options, 'modal-body')
    content = block_given? ? capture(&block) : args.shift

    content_tag(:div, options) do
      content
    end
  end
  
  # Returns a DIV for Bootstrap modal footer
  # Defaults to including #modal_footer_close_button.
  def modal_footer(*args, &block)
    options = canonicalize_options(args.extract_options!)
    options = ensure_class(options, 'modal-footer')
    
    content = if block_given?
      capture(&block)
    elsif args.size > 0
      args.shift
    else
      modal_footer_close_button
    end

    content_tag(:div, options) do
      content
    end
  end

  # Returns a Bootstrap modal close button
  def modal_header_close_button(show=true)
    return ''.html_safe unless show
    button("&times;".html_safe, type: 'button', class: 'close modal-close modal-header-close', data: {dismiss: 'modal'})
  end

  # Returns a close button for Bootstrap modal footer.
  def modal_footer_close_button(*args)
    options = canonicalize_options(args.extract_options!)
    options = ensure_class(options, 'modal-close modal-footer-close')
    options.merge!(data: {dismiss: 'modal'})
    args.unshift("Close") if args.empty?

    button(*args, options)
  end
  
  def modal_footer_ok_button(*args)
    options = canonicalize_options(args.extract_options!)
    options = ensure_class(options, 'modal-footer-ok')
    options.merge!(data: {dismiss: 'modal'})
    args.unshift("Ok") if args.empty?
  
    button(*args, options)
  end
  
  def modal_alert(*args, &block)
    options = canonicalize_options(args.extract_options!)
    header = options.delete(:header) || "Alert"

    modal(options) do
      modal_header(header) + 
      modal_body(*args, &block) + 
      modal_footer
    end
  end

  def modal_confirm(*args, &block)
    options = canonicalize_options(args.extract_options!)
    header = options.delete(:header) || "Confirmation"

    modal(options) do
      modal_header(header) + 
      modal_body(*args, &block) + 
      modal_footer do
        modal_footer_close_button(icon('remove', 'Cancel')) + 
        modal_footer_ok_button(icon('ok', :white, 'Ok'), :primary)
      end
    end
  end
  
end