class LayerOptions
  JQUERY_DIALOG_OPTIONS = [
    :autoOpen,
    :bgiframe,
    :buttons,
    :closeOnEscape,
    :dialogClass,
    :draggable,
    :height,
    :hide,
    :maxHeight,
    :maxWidth,
    :minHeight,
    :modal,
    :position,
    :resizable,
    :show,
    :stack,
    :title,
    :width,
    :zIndex
  ]
  
  JQUERY_DIALOG_CALLBACKS = [
    :beforeclose,
    :open,
    :focus,
    :dragStart,
    :drag,
    :dragStop,
    :resizeStart,
    :resize,
    :resizeStop,
    :close
  ]
  
  DEFAULT_LAYER_OPTIONS = {
    :width => 400,
    :modal => true,
    :draggable => false,
    :resizable => false,
    :auto => false,
    :title => "",
    :use_ajax => true,
    :autoOpen => true
  }
    
  def initialize(options)
    @options = DEFAULT_LAYER_OPTIONS.merge options
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
    "pkwde.layer.initialize_layer_#{functions_appendix}"
  end
  
  def ajax_call_function_name
    "pkwde.layer.ajaxCallFunction_#{functions_appendix}"
  end
  
  def ajax_callback_function_name
    "pkwde.layer.ajaxCallback_#{functions_appendix}"
  end
  
  def submit_form_function_name
    "pkwde.layer.submitForm_#{functions_appendix}"
  end
  
  def create_window_function_name
    "pkwde.layer.createWindow_#{functions_appendix}"
  end
  
  def close_function_name
    "pkwde.layer.closeFunction_#{functions_appendix}"
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
    return "{#{json.join(',')}}"
  end
end
