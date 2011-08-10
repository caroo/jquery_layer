require 'helpers/layer_helper'
require "model/layer_options"
require "jquery_layer/version"
require "jquery_layer/railtie"
require 'active_support/core_ext/string/output_safety'

module JqueryLayer
  module Config
    mattr_accessor :js_namespace
    mattr_accessor :content_for_key
    mattr_accessor :content_filter
  end
end