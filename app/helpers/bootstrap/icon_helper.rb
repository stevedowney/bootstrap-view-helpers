# Helper methods for Bootstrap icons.
#
# See: http://twitter.github.io/bootstrap/base-css.html#icons
#
# @example Icons
#   icon(:search)
#   icon(:search, :white)
#   icon(:search, :white, id: 'my-id')
#
# @example Icons with text
#   icon(:search, 'Search')
#   icon(:remove, :white, 'Delete')
#   icon(:ok, 'Save', id: 'my-id')
#
# @example Text without icon
#   # so text lines up when you have text but no icon
#   icon(:blank, 'No icon')
module Bootstrap::IconHelper
  
  # Returns a Bootstrap icon glyph.
  #
  # Optionally returns text with icon.
  # 
  # See class documentation (above) for examples.
  # @return [String]
  def icon(*args)
    ::Bootstrap::IconRenderer.new(self, *args).html
  end
  
end