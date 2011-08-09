class LayerOptions
  # Array of all options supported by jQuery UI Dialog class
  # see http://jqueryui.com/demos/dialog/ for further documentation
  JQUERY_DIALOG_OPTIONS = [
    :disabled,
    :autoOpen,
    :buttons,
    :closeOnEscape,
    :closeText,
    :dialogClass,
    :draggable,
    :height,
    :hide,
    :maxHeight,       
    :maxWidth,
    :minHeight,
    :minWidth,
    :modal,
    :position,
    :resizable,
    :show,
    :stack,
    :title,
    :width,
    :zIndex
  ].freeze
  
  # Array of all events supported by jQuery UI Dialog class
  # see http://jqueryui.com/demos/dialog/ for further documentation
  JQUERY_DIALOG_CALLBACKS = [
    :create,
    :beforeClose,
    :open,
    :focus,
    :dragStart,
    :drag,
    :resizeStart,
    :resize,
    :resizeStop,
    :close
  ].freeze
  
  # List of additional jquery layer options
  SUPPORTED_LAYER_OPTIONS = [
    :use_ajax,
    :content_for_script,
    :url
  ].freeze
  
  DEFAULT_LAYER_OPTIONS = {
    :width              => 400,
    :modal              => true,
    :draggable          => false,
    :resizable          => false,
    :auto               => false,
    :title              => "",
    :use_ajax           => true,
    :autoOpen           => true,
    :content_for_script => true,
    :debug              => false
  }
    
  def initialize(options)
    @options = DEFAULT_LAYER_OPTIONS.merge options
  end
  
  def content_for_script?
    @options[:content_for_script]
  end
  
  def dialog_options
    @dialog_options ||= @options.keys.inject({}) do |memo, key|
      memo[key] = @options[key] if JQUERY_DIALOG_OPTIONS.include?(key)
      memo
    end
  end
  
  def dialog_callbacks
    @dialog_callbacks ||= @options.keys.inject({}) do |memo, key|
      memo[key] = @options[key] if JQUERY_DIALOG_CALLBACKS.include?(key)
      memo
    end
  end
  
  def layer_options
    @layer_options ||= @options.keys.inject({}) do |memo, key| 
      memo[key] = @options[key] unless JQUERY_DIALOG_OPTIONS.include?(key) || JQUERY_DIALOG_CALLBACKS.include?(key)
      memo
    end
  end
  
  def functions_appendix
    @functions_appendix ||= (@options.hash + rand(50)).abs
  end
  private :functions_appendix
  
  def initialize_layer_function_name
    "#{JqueryLayer::Config.js_namespace}.layer_#{functions_appendix}.initialize"
  end
  
  def fetch_content_function_name
    "#{JqueryLayer::Config.js_namespace}.layer_#{functions_appendix}.fetchContent"
  end
  
  def content_received_function_name
    "#{JqueryLayer::Config.js_namespace}.layer_#{functions_appendix}.contentReceived"
  end
  
  def submit_form_function_name
    "#{JqueryLayer::Config.js_namespace}.layer_#{functions_appendix}.submitForm"
  end
  
  def close_function_name
    "#{JqueryLayer::Config.js_namespace}.layer_#{functions_appendix}.closeLayer"
  end
  
  def url
    @options and @options[:url]
  end
  
  def method_missing(method_name, *args)
    if(@options.has_key? method_name)
      return @options[method_name]
    else
      super
    end
  end
  
  def to_json
    json  = []
    json += dialog_options.map do |key, value| 
      if value.kind_of? Numeric or value.kind_of? TrueClass or value.kind_of? FalseClass
        "\"#{key}\":#{value}"
      elsif value.kind_of? Array or value.kind_of? Hash
        "\"#{key}\":#{value.to_json}"
      else
        "\"#{key}\":\"#{value}\""
      end
    end
    json += dialog_callbacks.map{|key, value| "\"#{key}\":#{value}"}
    return "{#{json.join(',')}}".html_safe
  end
end
