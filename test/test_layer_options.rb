require 'helper'

class TestLayerOptions < Test::Unit::TestCase
  
  def setup
    @layer_options = LayerOptions.new({
    :width => 500,
    :height => 375,
    :position => '[150,130]',
    :url => "url",
    :layer_selector => "#layer_container", 
    :trigger_selector => "li#show-video > a",
    :title => false,
    :open => "callback_function"})
  end
  
  def test_should_create_layer_options
    assert_equal @layer_options.height, 375
    assert_equal @layer_options.url, "url"
    
    assert_kind_of Hash, @layer_options.dialog_options
    assert_kind_of Hash, @layer_options.dialog_callbacks
    assert_kind_of Hash, @layer_options.layer_options
  end
  
  def test_should_have_to_json_method
    # assert_equal "{\"resizable\":false,\"height\":375,\"position\":\"[150,130]\",\"title\":\"\",\"modal\":true,\"width\":400,\"draggable\":false,\"open\":callback_function}",  @layer_options.to_json
    assert json = @layer_options.to_json
    assert json.html_safe?
  end
end