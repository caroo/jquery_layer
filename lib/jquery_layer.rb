$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'helpers/layer_helper'

module JqueryLayer
  VIEW_PATH = File.join(File.dirname(__FILE__), *%w[views])
  
  # Damit die in diesem Gem verwendeten ERB-Templates gefunden werden koennen,
  # muss der Pfad zu diesen Templates mit Hilfe dieser Methode zu den
  # <tt>ActionController::Base.view_paths</tt> hinzugefuegt werden. 
  def self.expand_view_path
    begin
      ActionController::Base.view_paths << ActionView::PathSet.type_cast(VIEW_PATH) unless ActionController::Base.view_paths.include?(VIEW_PATH)
    rescue Exception => e
       Rails.logger.error("Cannot add jquery_layer path to view paths")
       Rails.logger.error(e.backtrace.join("\n"))
    end
  end
end