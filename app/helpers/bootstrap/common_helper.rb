# Utililty methods used by Bootstrap::*Heler classes
module Bootstrap::CommonHelper
  ArgumentError = Class.new(::ArgumentError)
  
  # Returns a new Hash with:
  # * keys converted to Symbols
  # * the +:class+ key has it value converted to an Array of String
  # @raise [ArgumentError] if _hash_ is not a Hash
  # @return [Hash]
  def canonicalize_options(hash)
    raise ArgumentError.new("expected a Hash, got #{hash.inspect}") unless hash.is_a?(Hash)

    hash.symbolize_keys.tap do |h|
      h[:class] = arrayify_class_and_stringify_elements(h[:class])
    end
  end

  # Returns a new Array of String
  # @example
  #   arrayify_class_and_stringify_elements(nil)            #=> [] 
  #   arrayify_class_and_stringify_elements('foo')          #=> ["foo"]
  #   arrayify_class_and_stringify_elements([:foo, 'bar'])  #=> ["foo", "bar"]
  # @return [Array of String]
  def arrayify_class_and_stringify_elements(klass)
    return false if klass == false
    
    case
    when klass.blank? then []
    when klass.is_a?(Array) then klass
    else klass.to_s.strip.split(/\s/)
    end.map(&:to_s)
  end
  
  # Returns down-caret character used in various dropdown menus.
  # @param [Hash] options html options for <span>
  # @example
  #   caret(id: 'my-id')   #=> <span class='caret' id='my-id'></span>
  # @return [String]
  def caret(options={})
    options= canonicalize_options(options)
    options = ensure_class(options, 'caret')
    content_tag(:span, nil, options)
  end
  
  # Returns new Hash where :class value includes _klasses_.
  # 
  # Assumes _hash_ has a key :class (Symbol) whose value is an Array of String.
  # {Bootstrap::CommonHelper#canonicalize_options} will return such a Hash.
  #
  # @example
  #   ensure_class({class: []}, 'foo')                               #=> {class: 'foo'}
  #   ensure_class({class: ['bar'], id: 'my-id'}, ['foo', 'foo2'])   #=> {:class=>["bar", "foo", "foo2"], :id=>"my-id"}
  # @param [Hash] hash
  # @param [String, Array] klasses one or more classes to add to the +:class+ key of _hash_
  # @return [Hash]
  def ensure_class(hash, klasses)
    hash.dup.tap do |h|
      Array(klasses).map(&:to_s).each do |k|
        h[:class] << k unless h[:class].include?(k)
      end
    end
  end

  # Returns extra arguments that are Bootstrap modifiers.  Basically 2nd argument
  # up to (not including) the last (Hash) argument.
  #
  # @example
  #   extract_extras('text')  #=> []
  #   extract_extras('text', :small, :info, id: 'foo')  #=> [:small, :info]
  # @return [Array]
  def extract_extras(*args)
    args.extract_options!
    args.shift
    args
  end
  
end