module Bootstrap::CommonHelper
  ArgumentError = Class.new(::ArgumentError)
  
  def canonicalize_options(hash)
    raise ArgumentError.new("expected a Hash, got #{hash.inspect}") unless hash.is_a?(Hash)

    hash.symbolize_keys.tap do |h|
      h[:class] = arrayify_class_and_stringify_elements(h[:class])
    end
  end

  # Returns a new Array of String
  # 
  #   arrayify_class_and_stringify_elements(nil)            #=> [] 
  #   arrayify_class_and_stringify_elements('foo')          #=> ["foo"]
  #   arrayify_class_and_stringify_elements([:foo, 'bar'])  #=> ["foo", "bar"]
  def arrayify_class_and_stringify_elements(klass)
    return false if klass == false
    
    case
    when klass.blank? then []
    when klass.is_a?(Array) then klass
    else klass.to_s.strip.split(/\s/)
    end.map(&:to_s)
  end
  
  # Returns down-caret character used in various dropdown menus.
  def caret(options={})
    options= canonicalize_options(options)
    options = ensure_class(options, 'caret')
    content_tag(:span, nil, options)
  end
  
  # Ensures that _hash_ has key of :class that includes _klass_.
  # 
  # Assumes there is a key :class (Symbol) whose value is an Array of String.
  # #canonicalize_options will return such an array.
  #
  #   ensure_class({}, 'foo')                            #=> {class: 'foo'}
  #   ensure_class({class: 'bar', id: 'my-id'}, 'foo')   #=> {:class=>["bar", "foo"], :id=>"my-id"}
  def ensure_class(hash, klass)
    hash.dup.tap do |h|
      Array(klass).map(&:to_s).each do |k|
        h[:class] << k unless h[:class].include?(k)
      end
    end
    
    # arrayify_class(hash).tap do |h|
    #   klasses = Array(klass).map(&:to_s)
    #   klasses.each do |k|
    #     h[:class] << k unless h[:class].include?(k)
    #   end
    # end
  end

  # Returns extra arguments that are Bootstrap modifiers.  Basically 2nd argument
  # up to (not including) the last (hash) argument.
  #
  #   extract_extras('text')  #=> []
  #   extract_extras('text', :small, :info, id: 'foo')  #=> [:small, :info]
  def extract_extras(*args)
    args.extract_options!
    args.shift
    args
  end
  
end