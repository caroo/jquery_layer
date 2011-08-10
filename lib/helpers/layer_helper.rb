module JqueryLayer
  module LayerHelper
    # show_layer rendert einen jquery.ui Dialog, der angezeigt wird, wenn ein
    # in den options angegebener Trigger angeklickt wird. Der Inhalt des
    # Dialog-Fensters wird in das layer_selector Element gerendert. Beim
    # rendern werden Elemente mit der CSS-Klasse .cancel_button durch die
    # Dialog spezifischen Buttons ersetzt. Das gleiche geschieht fuer alle
    # Elemente mit der KLasse .submit_button.
    # Folgende Optionen sind moeglich, siehe dazu auch
    # http://jqueryui.com/demos/dialog/:
    #  * <tt>:width(default = 500)</tt>
    #  * <tt>:url</tt>
    #  * <tt>:modal(default = true)</tt>
    #  * <tt>:draggable(default = false)</tt>
    #  * <tt>:resizable(default = false)</tt>
    #  * <tt>:auto(default = false)</tt>
    #  * <tt>:title(default = "")</tt>
    #  * <tt>:fetch_content(default = true)</tt>
    #  * <tt>:autoOpen(default = true)</tt>
    #  * <tt>:debug(default = false)</tt>
    #  * <tt>:script_tag(default = true)</tt>
    
    def show_layer(options, &block)
      layer_options = LayerOptions.new(options)
      
      additional_content = if block_given?
        capture(layer_options, &block)
      end
      render "jquery_layer/layer", :layer_options => layer_options, :additional_content => additional_content
    end
    
    # ads nofollow to all links
    def link_to_layer(*args, &block)
      if block_given?
        options = args.first || {}
        html_options = args.second || {}
        html_options[:rel] = "nofollow"
        link_to options, html_options, &block
      else
        name = args.first
        options = args.second
        html_options = args.third || {}
        html_options[:rel] = "nofollow"
        link_to name, options, html_options, &block
      end
    end

  end
end