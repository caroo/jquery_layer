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
    :fetch_content,
    :content_for_script,
    :url,
    :trigger_selector,
    :layer_selector,
    :debug_mode,
    :script_tag,
    :destroy_on_exit
  ].freeze
  
  DEFAULT_LAYER_OPTIONS = {
    :width              => 400,
    :modal              => true,
    :draggable          => false,
    :resizable          => false,
    :auto               => false,
    :title              => "",
    :fetch_content      => true,
    :autoOpen           => true,
    :content_for_script => true,
    :debug              => false,
    :script_tag         => true,
    :destroy_on_exit    => true
  }.freeze
  
  (JQUERY_DIALOG_OPTIONS + JQUERY_DIALOG_CALLBACKS + SUPPORTED_LAYER_OPTIONS).each do |supported_method|
    define_method supported_method do
      @options[supported_method]
    end
  end
    
  def initialize(options)
    @options = DEFAULT_LAYER_OPTIONS.merge options
    if @options.has_key?(:use_ajax)
      ActiveSupport::Deprecation.warn(":use_ajax option is deprecated. Use fetch_content instead", caller)
      @options[:fetch_content] = @options[:use_ajax] unless options.has_key?(:fetch_content)
    end
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
  
  def current_namespace
    @current_namespace ||= "layer" + (@options.hash + rand(50)).abs.to_s
  end
  
  def namespace
    @namespace ||= JqueryLayer::Config.js_namespace + "." + current_namespace
  end
  
  def init_layer_function_name(format = :full)
    name = "initLayer"
    name.insert(0, ".").insert(0, namespace) if format.to_sym == :full
    name
  end
  
  def fetch_content_function_name(format = :full)
    name = "fetchContent"
    name.insert(0, ".").insert(0, namespace) if format.to_sym == :full
    name
  end
  
  def content_received_function_name(format = :full)
    name = "contentReceived"
    name.insert(0, ".").insert(0, namespace) if format.to_sym == :full
    name
  end
  
  def close_layer_function_name(format = :full)
    name = "closeLayer"
    name.insert(0, ".").insert(0, namespace) if format.to_sym == :full
    name
  end
  
  def open_layer_function_name(format = :full)
    name = "openLayer"
    name.insert(0, ".").insert(0, namespace) if format.to_sym == :full
    name
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
