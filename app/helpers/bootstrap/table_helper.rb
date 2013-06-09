# Rails helper for producing consistent Bootstrap styled tables.
#
# @example
#   # in your view
#
#   <%= bs_table_tag do %>
#     ...
#
#   <%= bs_table_tag(id: 'my-id', class: 'another-class') do %>
#     ...
#
#   # configure a custom set of classes:
#   Bootstrap::TableHelper.classes[:admin] = %w(admin table table-striped table-compact)
#   
#   <%= bs_table_tag(:admin) do %>
#
#   
module Bootstrap::TableHelper
  InvalidClassListsKeyError = Class.new(StandardError)
  
  DEFAULT_CLASS_LIST = %w(table table-bordered table-striped table-hover)
  
  mattr_accessor :class_lists
  self.class_lists = {default: DEFAULT_CLASS_LIST.dup}
  
  # Produces a wrapper TABLE element with Bootstrap classes.
  #
  # @overload bs_table_tag(class_list=:default, options={})
  # @param class_list [Symbol] a key of the +Bootstrap::class_lists+ Hash
  # @param options [Hash] unrecognized options become attributes of the <table> element
  # @return [String]
  def bs_table_tag(*args, &block)
    options = canonicalize_options(args.extract_options!)
    table_classes = _get_table_classes(args.shift)
    options = ensure_class(options, table_classes)
    
    content_tag(:table, options) do
      yield
    end
  end
  
  private
  
  def _get_table_classes(key)
    key = key.presence || :default
    self.class_lists.fetch(key)
  rescue KeyError
    raise(InvalidClassListsKeyError, "did not find key: #{key.inspect} -- Did you forget to set Bootstrap::TableHelper.class_lists[#{key.inspect}]?")
  end
   
end