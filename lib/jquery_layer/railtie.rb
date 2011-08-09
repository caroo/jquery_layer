require "rails/railtie"

module JqueryLayer
  class Railtie < Rails::Railtie
    config.jquery_layer = ActiveSupport::OrderedOptions.new
      
    initializer "jquery_layer.setup_view_paths" do |app|
      view_path = File.expand_path(File.join(File.dirname(__FILE__), *%w[.. views]))
      ActionController::Base.append_view_path(view_path)  unless ActionController::Base.view_paths.include?(view_path)
    end
    
    config.after_initialize do |app|
      JqueryLayer::Config.js_namespace    = app.config.jquery_layer.js_namespace || "jquery_layer"
      JqueryLayer::Config.content_for_key = app.config.jquery_layer.content_for_key || :script
    end
  end
end
