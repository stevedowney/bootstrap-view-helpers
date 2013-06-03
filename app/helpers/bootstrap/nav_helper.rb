# Rails view helpers for various Bootstrap navigation components.
#
# See: http://twitter.github.io/bootstrap/components.html#navbar
# @example navigation bar (across top of page)
#   <%= nav_bar do %>      
#
#     <%= brand('Span Brand')%>
#     <%= brand('Link Brand', url: '#')%>
#
#     <%= nav_bar_links do %>
#       <%= nav_bar_link('Active', '#', active: true) %>
#       <%= nav_bar_link('Link 1', '/link1') %>
#       <%= nav_bar_divider %>
#       <%= nav_bar_link('Link 2', '/link2') %>
#     <% end >
# 
#     <%= nav_dropdown(pull: 'right') %>
#       <%= nav_dropdown('Foo') do %>
#         <%= dropdown_item('One', 'foo')%>
#       <% end %>
#     <% end %>
#
#   <% end %>
#
# @example navigation list (e.g., in sidebar)
#   <%= nav_list(id: 'my') do %>
#     <%= nav_list_header('Buttons & Labels') %>
#     <%= dropdown_item('Buttons', 'butons')%>
#     <%= dropdown_item('Labels', 'butons')%>
#   <% end %>
module Bootstrap::NavHelper
  
  # Returns a Bootstrap navigation bar
  # @yield yield block usually consists of other {Bootstrap::NavHelper} helpers
  # @yieldreturn the contents of the navigation bar
  # @return [String]
  def nav_bar()
    content_tag(:header, class: 'navbar') do
      content_tag(:nav, class: 'navbar-inner') do
        yield
      end
    end
  end
  
  # Returns a Bootstrap brand element
  #
  # @param [String] text text of the brand
  # @param [Hash] options except for +:url+, becomes html attributes of returned tag
  # @option options [String] :url if present, returned tag is an <a> (else <span>)
  # @option options [Boolean] :with_environment if present, environment is appended to _text_ and
  #   and a class of "rails-<Rails.env>" is added to the returned tag.
  # @return [String] <a> if +:url+ option present, else <span>
  def brand(text, options = {})
    options = canonicalize_options(options)
    options = ensure_class(options, 'brand')

    with_environment = options.delete(:with_environment)
    if with_environment && Rails.env != 'production'
      text = "#{text} - #{Rails.env}"
      options = ensure_class(options, "rails-#{Rails.env}") 
    end

    url = options.delete(:url)
    
    if url.present?
      link_to(text, url, options)
    else
      content_tag(:span, text, options)
    end
  end
  
  # Returns <div> for a group of nav bar links, <ul>s.
  #
  # Usually called in +yield+ block of {Bootstrap::NavHelper#nav_bar}
  #
  # @param options [Hash] options except for +:pull+ become html attributes of generated <div>
  # @option options [:left, :right] pull will add class of "pull-left|right" for Bootstrap nav bar positioning
  # @yield block usually consists of calls to {Bootstrap::NavHelper#nav_bar_link} and {Bootstrap::NavHelper#nav_bar_divider}
  # @return [String] <div class='nav'> containing results of yielded block
  def nav_bar_links(options={})
    options = canonicalize_options(options)
    options = ensure_class(options, 'nav')
    
    if pull = options.delete(:pull)
      options = ensure_class(options, "pull-#{pull}")
    end
    
    content_tag(:div, options) do
      yield
    end
  end
  
  # Returns a nav_bar_link
  #
  # Usually called within yield block of {Bootstrap::NavHelper#nav_bar}
  #
  # @param [String] text text of link
  # @param [String] url url of link
  # @param [Hash] options except for +:active+, becomes html attributes of link
  # @option options [true] :active if set to true, displays as inactive
  # @return [String] returns <a> within <li>
  def nav_bar_link(text, url, options={})
    a_options = canonicalize_options(options)
    active = a_options.delete(:active)
    
    li_options = {class: ('active' if active)}
    
    content_tag(:li, li_options) do
      link_to(text, url, a_options)
    end
  end
  
  # Returns divider (vertical bar) for separating items in a nav_bar
  #
  # @return [String] <li class="divider-vertical"></li>
  def nav_bar_divider
    content_tag(:li, nil, class: "divider-vertical")
  end
  
  # Returns nav list
  #
  # @param [Hash] options becomes html attributes of enclosing <div>
  # @yield block consists of calls to {Bootstrap::NavHelper#nav_list_header} and {Bootstrap::NavHelper#dropdown_item} 
  # @return [String] <div class='well'><ul class='nav nav-list'> containg results of yielded block
  def nav_list(options={})
    options = canonicalize_options(options)
    options = ensure_class(options, 'well')
    content_tag(:div, options) do
      content_tag(:ul, class: 'nav nav-list') do
        yield
      end
    end
  end
  
  # Returns header for nav_list
  #
  # @param text [String] text of header
  # @return [String] <li.nav-header>text</li>
  def nav_list_header(text)
    content_tag(:li, text, class: 'nav-header')
  end
  
  # Wraps _text_ so it has proper leading and color for text in a nav bar.  Usually
  # in a +nav_bar_links+ block
  #
  # Note that the Bootstrap CSS has no horizontal margins or padding.  This method
  # pads with three +\&nbsp;+ at front and back.  Use +pad: false+ to suppress padding.
  #
  # @param text [String] text to display
  # @param options [Hash] unknown options become html attributes for the <p>
  # @option options [:left, :right] :pull (:left) adds the Boostrap positioning class
  # @option options [Boolean] :pad (true) include padding around text
  # @return [String]
  def nav_bar_text(text, options={})
    options = canonicalize_options(options)

    unless options.delete(:pad) == false
      padding = ("&nbsp;" * 3).html_safe
      text = padding + h(text) + padding
    end
    
    pull_class = (options.delete(:pull).to_s == 'right' ? 'pull-right' : 'pull-left')
    options = ensure_class(options, [pull_class, 'navbar-text'])
    
    content_tag(:p, text, options)
  end
end