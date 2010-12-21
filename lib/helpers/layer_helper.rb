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
    #  * <tt>:height(default = 400)</tt>
    #  * <tt>:url</tt>
    #  * <tt>:modal(default = true)</tt>
    #  * <tt>:draggable(default = false)</tt>
    #  * <tt>:resizable(default = false)</tt>
    #  * <tt>:auto(default = false)</tt>
    #  * <tt>:title(default = "")</tt>
    #  * <tt>:use_ajax(default = true)</tt>
    
    def show_layer(options)
      if !@layer_header_rendered && options[:render_header]
        render :partial => "/layer_header"
        @layer_header_rendered = true
      end
      render :partial => "/layer", :object => options || {}
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