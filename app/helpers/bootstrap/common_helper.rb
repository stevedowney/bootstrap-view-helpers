module Bootstrap::CommonHelper
  ArgumentError = Class.new(::ArgumentError)
  
  # Returns a new hash with the :class key's value converted to an
  # Array with each element converted to a String.
  # 
  #   arrayify_class({})                       #=> {:class=>[]} 
  #   arrayify_class(:class => 'foo')          #=> {:class=>["foo"]}
  #   arrayify_class(:class => [:foo, 'bar'])  #=> {:class=>["foo", "bar"]} 
  def arrayify_class(hash)
    raise ArgumentError.new("expected a Hash, got #{hash.inspect}") unless hash.is_a?(Hash)
    
    return hash if hash[:class] == false
    
    hash.dup.tap do |h|
      classes = h[:class]
      h[:class] = case
        when classes.blank? then []
        when classes.is_a?(Array) then classes.dup
        else classes.to_s.split(/\s/)
        end
      h[:class].map!(&:to_s)
    end
  end
  
  # Returns down-caret character used in various dropdown menus.
  def caret(options={})
    options = ensure_class(options, 'caret')
    content_tag(:span, nil, options)
  end
  
  # Ensures that _hash_ has key of :class that includes _klass_.
  #
  #   ensure_class({}, 'foo')                            #=> {class: 'foo'}
  #   ensure_class({class: 'bar', id: 'my-id'}, 'foo')   #=> {:class=>["bar", "foo"], :id=>"my-id"}
  def ensure_class(hash, klass)
    arrayify_class(hash).tap do |h|
      klasses = Array(klass).map(&:to_s)
      klasses.each do |k|
        h[:class] << k unless h[:class].include?(k)
      end
    end
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