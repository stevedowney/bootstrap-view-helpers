# bootstrap-view-helpers

This gem provides helper methods for various Bootstrap components.

Includes support for:

  * buttons
    * `<button>`
    * `<a>` styled as button
  * labels and badges
  * dropdowns
    * nav dropdowns
    * button dropdowns
    * split-button dropdowns
  * accordion
  
## Installation

Add it to your Gemfile:

```ruby
gem "bootstrap-view-helpers"
```

Run bundler:

```sh
bundle install
```

## Examples

### Badges

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
