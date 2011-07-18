require "rails/railtie"

module JqueryLayer
  class Railtie < Rails::Railtie  
    initializer "jquery_layer.setup_view_paths" do |app|
      view_path = File.expand_path(File.join(File.dirname(__FILE__), *%w[.. views]))
      ActionController::Base.append_view_path(view_path)  unless ActionController::Base.view_paths.include?(view_path)
    end
  end
end
