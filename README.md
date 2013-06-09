# bootstrap-view-helpers

[![Gem Version](https://badge.fury.io/rb/bootstrap-view-helpers.png)](http://badge.fury.io/rb/bootstrap-view-helpers)
[![Build Status](https://travis-ci.org/stevedowney/bootstrap-view-helpers.png)](https://travis-ci.org/stevedowney/bootstrap-view-helpers)
[![Code Climate](https://codeclimate.com/github/stevedowney/bootstrap-view-helpers.png)](https://codeclimate.com/github/stevedowney/bootstrap-view-helpers)
[![Coverage Status](https://coveralls.io/repos/stevedowney/bootstrap-view-helpers/badge.png?branch=master)](https://coveralls.io/r/stevedowney/bootstrap-view-helpers?branch=master)

This gem provides helper methods for various Bootstrap components.

Includes support for:

  * navigation
    * nav bar
    * nav list
  * modal dialogs
    * modal_trigger
    * modal_alert
    * modal_confirm
  * icons
    * icons with text 
  * buttons
    * `<button>`
    * `<a>` styled as button
  * button groups
  * button toolbars
  * labels and badges
  * dropdowns
    * nav dropdowns
    * button dropdowns
    * split-button dropdowns
  * accordion
  * form helpers
    * submit_tag_button
    * cancel_tag_button
  * alerts
  * table helper
  
For the complete list of available helpers see the [API documentation](http://rubydoc.info/gems/bootstrap-view-helpers/frames/file/README.md).

## Note

This is a new gem undergoing a lot of change.  There is a chance that some backwards
compatibility will be broken until things settle down.  

## Installation

### Bootstrap Requirement

*Bootstrap is required in your application, but bootstrap-view-helpers does not 
enforce this.  You are responsible for Bootstrap being present in your application.*

There are gems for this including [bootstrap-sass](https://github.com/thomas-mcdonald/bootstrap-sass).

### Installing bootstrap-view-helpers

Add it to your Gemfile:

```ruby
gem "bootstrap-view-helpers"
```

Run bundler:

```sh
bundle install
```

See working examples served up in your application (assuming you have Bootstrap):

```
http://<your app>/bootstrap_view_helpers
```

Url helpers for the example page: `bvh_path` and `bvh_url`.

## API Documentation

Complete [API documentation](http://rubydoc.info/gems/bootstrap-view-helpers/frames/file/README.md) at [RubyGems.org](https://rubygems.org/).

## Examples

### Navigation

#### Navigation Bar
```
<%= nav_bar do %>      

  <%= brand('Span Brand') %>
  <%= brand('Link Brand', url: '#') %>
  <%= brand('MyApp', with_environment: true) %>

  <%= nav_bar_links do %>
    <%= nav_bar_link('Active', '#', active: true) %>
    <%= nav_bar_link('Link 1', '/link1') %>
    <%= nav_bar_divider %>
    <%= nav_bar_link('Link 2', '/link2') %>
  <% end %>

  <%= nav_bar_links(pull: 'right') do %>
    <%= nav_bar_text('logged in as admin') %>
    <%= nav_dropdown('Dropdown 1') do %>
      <%= dropdown_item('One', 'foo')%>
    <% end %>
  <% end %>
  
<% end %>
```

#### Navigation List (sidebar)
```erb
<%= nav_list(id: 'my') do %>
  <%= nav_list_header('Buttons & Labels') %>
  <%= dropdown_item('Buttons', 'butons')%>
  <%= dropdown_item('Labels', 'butons')%>
<% end %>
```

### Modal Dailogs an Friends

#### Simple Example Using Defaults

```erb
<%= modal_trigger("Click to show modal", href: '#modal-1') %>

<%= modal(id: 'modal-1') do %>
  <%= modal_header("Heading") %>
  <%= modal_body("The body ...") %>
  <%= modal_footer %>
<% end %>
```

#### Block From Using Other Modal Helpers

```erb
<%= modal_trigger("Click to show modal", href: '#modal-2', class: 'btn btn-primary') %>

<%= modal(id: 'modal-2') do %>
  <%= modal_header(close: false) do %>
    Heading <small>(with no close button)</small>
  <% end %>
  <%= modal_body do %>
    <h4>Modal Body</h4>
    <p>With additional markup</p>
  <% end %>
  <%= modal_footer do %>
    <%= button("Save", :primary) %>
    <%= modal_footer_close_button("Dismiss") %>
  <% end %>
<% end %>
```

#### Modal Alert - Similar to JS Alert

```erb
<%= modal_trigger("Click to show Alert", href: '#alert') %>
<%= modal_alert("Watch out", id: 'alert') %>

<%= modal_trigger("Click to show Alert w/block", href: '#alert-block') %>
<%= modal_alert(id: 'alert-block', header: 'Custom Header') do %>
  This is some <b>bold</b> text from the <code>modal_alert</code> block.
<% end %>
```

#### Modal Confirm - Similar to JS Confirm

```erb
<%= modal_trigger("Click to show Confirm", href: '#confirm') %>
<%= modal_confirm("Watch out", id: 'confirm') %>

<%= modal_trigger("Click to show Confirm w/block", href: '#confirm-block') %>
<%= modal_confirm(id: 'confirm-block', header: 'Custom Header') do %>
  This is some <b>bold</b> text from the <code>modal_confirm</code> block.
<% end %>
```

### Icons

See: http://twitter.github.io/bootstrap/base-css.html#icons

Icons
```ruby
icon(:search)
icon(:search, :white)
icon(:search, :white, id: 'my-id')
```

Icons with Text
```ruby
icon(:search, 'Search')
icon(:remove, :white, 'Delete')
icon(:ok, 'Save', id: 'my-id')
```

Line up text when some have icons and some don't
```ruby
icon(:search, 'With icon')  # shows search icon
icon(:blank, 'No icon')     # no icon, text will aligin if icons are stacked
```

### Buttons

```ruby
# button
button('Default')

# add url option to make <a> styled as button
button('Home', url: '/')

# a button styled as a link
button('Home', :link)

# give it a type; see BUTTON_TYPES
button('Info', :info)

# give it a size (see BUTTON_SIZES)
button('Small', :small)

# size, type, additional class and additional html attributes
button('Warning', :warning, :large, id: 'warn-id', class: 'more-class', my_key: 'my_value')
```

### Button Groups

```erb
<%= button_group do %>
  <%= button("Left", url: "/left") %>
  <%= button("Right", id: 'right') %>
<% end %>
```

### Button Toolbars

```erb
<%= button_toolbar do %>
  <%= button('Single Button', url: '/single') %>
  <%= button_group do %>
    <%= button('Group Button 1') %>
    <%= button('Group Button 2') %>
  <% end %>
  <%= button('Another Single') %>
<% end %>
```
### Labels and Badges

http://twitter.github.io/bootstrap/components.html#labels-badges

#### Labels (Stamps)

Because `label` is a Rails helper method we use `stamp` -- because Elle thinks it looks like a stamp.

Supports the Bootstrap label types:
  * default
  * success
  * warning
  * important
  * info
  * inverse
  
```erb
<%= stamp('Default') %>
<%= stamp('Info', :info) %>
<%= stamp('Warning', :warning, id: 'warn-id', class: 'more-class', my_key: 'my_value') %>
```

#### Badges
Supports the Bootstrap badge types: 
  * default
  * success
  * warning
  * important
  * info
  * inverse
  
```erb
<%= badge('Default') %>
<%= badge('Info', :info) %>
<%= badge('Warning', :warning, id: 'warn-id', class: 'more-class', my_key: 'my_value') %>
```


### Accordions

See: http://twitter.github.io/bootstrap/javascript.html#collapse

```erb
<%= accordion do %>

  <%= accordion_group('Section 1', open: true) do %>
    content for group 1
  <% end >

  <%= accordion_group('Section 1') do %>
    content for group 2
  <% end %>

<% end %>
```

### Form Helpers

#### submit_tag_button

Returns <input> similar to +#submit_tag()+ but:
  * styled like a Bootstrap button, type `:primary`
  * has `:disable_with` set to "Processing ..."
  
```ruby
submit_button_tag   # => <input class="btn btn-primary" data-disable-with="Processing ..." name="commit" type="submit" value="Save changes" />
submit_button_tag('Save')
submit_button_tag('Delete', :danger)
submit_button_tag('Big', :large)
submit_button_tag('With Options', :small, :info, id: 'my-id')
```

#### cancel_tag_button

Convenience method for standard "Cancel" button.  `<a>` tag styled as Bootstrap button.

```ruby
cancel_button_tag(url: '/')  # => <a href="/" class="btn">Cancel</a>
cancel_button_tag('Go Back', url: '/')
cancel_button_tag(:info, url: '/')
cancel_button_tag(:large, url: '/')
cancel_button_tag('Return', :small, :warning, url: '/', id: 'my-id')
```

### Alerts

[Bootstrap Documentation](http://twitter.github.io/bootstrap/components.html#alerts)
[API Documentation](http://rubydoc.info/gems/bootstrap-view-helpers/Bootstrap/AlertHelper)

```erb
<%= alert('Default Alert') %>
<%= alert('Type :info', :info) %>
<%= alert('Type :success', :success) %>
<%= alert('Type :error', :error) %>

<%= alert('Default alert with heading', heading: 'Warning!') %>
<%= alert('No close button', close: false) %>
<%= alert("Type :block gives some more padding", :block ) %>
<%= alert("Unknown options are html attributes", id: 'my-id', class: 'my-class') %>

<%= alert :success do %>
  <%= alert_heading('A List') %>
  <ul>
    <li>One</li>
    <li>Two</li>
  </ul>
<% end %>
```

### Flash

[API Documentation](http://rubydoc.info/gems/bootstrap-view-helpers/Bootstrap/FlashHelper)

```erb
# in a layout or view

<%= flash_messages %>
<%= flash_messages close: false %>
<%= flash_messages class: 'flash', id: 'my-flash' %>
```

```ruby
# override default mapping (e.g., in initializer)

Bootstrap::FlashHelper.mapping[:notice] = :success
Bootstrap::FlashHelper.mapping[:mistake] = :error
```

### Table Helper

* [API Documentation](http://rubydoc.info/gems/bootstrap-view-helpers/Bootstrap/TableHelper)
* [Bootstrap Documentation](http://twitter.github.io/bootstrap/base-css.html#tables)

Don't keep repeating the Bootstrap table classes:

```erb
# instead of
<table class='table table-bordered table-striped table-hover'>
  ...
</table>

# do this
<%= bs_table_tag do %>
  ...
<% end %>
```

Customize the classes used (e.g. in an initializer):

```ruby
# change the default
Bootstrap::TableHelper.class_lists[:default] = 'table table-striped'

# create a custom class list
Bootstrap::TableHelper.class_lists[:admin] = 'admin table table-striped table-compact'

# use the custom list
<%= bs_table_tag(:admin) do %>
  ...
<% end %>
```
