module Bootstrap::NavHelper
  
  def nav_bar()
    content_tag(:header, class: 'navbar') do
      content_tag(:nav, class: 'navbar-inner') do
        yield
      end
    end
  end
  
  def brand(text, options = {})
    options = canonicalize_options(options)
    options = ensure_class(options, 'brand')
    url = options.delete(:url)
    
    if url.present?
      link_to(text, url, options)
    else
      content_tag(:span, text, options)
    end
  end
  
  def nav_bar_links(options={})
    options = canonicalize_options(options)
    options = ensure_class(options, 'nav')
    
    content_tag(:div, options) do
      yield
    end
  end
  
  def nav_bar_link(text, url, options={})
    a_options = canonicalize_options(options)
    active = a_options.delete(:active)
    
    li_options = {class: ('active' if active)}
    
    content_tag(:li, li_options) do
      link_to(text, url, a_options)
    end
  end
  
  def nav_bar_divider
    content_tag(:li, nil, class: "divider-vertical")
  end
  
  def nav_list(options={})
    options = canonicalize_options(options)
    options = ensure_class(options, 'well')
    content_tag(:div, options) do
      content_tag(:ul, class: 'nav nav-list') do
        yield
      end
    end
  end
  
  def nav_list_header(text)
    content_tag(:li, text, class: 'nav-header')
  end
end