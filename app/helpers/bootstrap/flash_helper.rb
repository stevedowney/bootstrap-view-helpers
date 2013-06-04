# Rails helpers for producing flash messages styled as Bootstrap alert boxes.
#
# @example
#   # in a layout or view
#
#   flash_messages
#   flash_messages close: false
#   flash_messages class: 'flash', id: 'my-flash'
#   
#   # override default mapping
#
#   Bootstrap::FlashHelper.mapping[:notice] = :success
#   Bootstrap::FlashHelper.mapping[:mistake] = :error
#   
module Bootstrap::FlashHelper
  DEFAULT_MAPPING = {
    :notice => :info,
    :alert => :error,
  }
  
  mattr_accessor :mapping
  self.mapping = DEFAULT_MAPPING.dup
  
  # Returns Bootstrap alerts for each entry in +flash+
  #
  # @param options [Hash] unrecognized options are passed the the {Bootstrap::AlertHelper#alert} method
  # @option options [Boolean] :close if +false+ the close button is not shown
  # @return [String]
  def flash_messages(options={})
    messages = flash.map { |type, message| _bs_flash_for(type, message, options) }
    safe_join(messages, "\n")
  end
  
  private
  
  def _bs_flash_for(type, message, options={})
    options = canonicalize_options(options)
    alert_class = _bs_alert_class_for(type)
    options = ensure_class(options, alert_class)
    
    alert(message, options)
  end
  
  def _bs_alert_class_for(type)
    mapped_type = _bs_map_type(type)
    
    "alert-#{mapped_type}"
  end
  
  def _bs_map_type(type)
    mapping[type.to_sym] || type
  end
    
end