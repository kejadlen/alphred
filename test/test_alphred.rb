require_relative "test_helper"

class TestItems < AlphredTest
  def test_empty
    items = Items.new
    assert_equal <<-XML, items.to_xml
<?xml version="1.0" encoding="UTF-8"?>
<items>
</items>
    XML
  end
end
