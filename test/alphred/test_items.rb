require_relative "../test_helper"

class TestItems < AlphredTest
  def test_empty
    items = Items.new
    assert_equal <<-XML, items.to_xml
<?xml version="1.0" encoding="UTF-8"?>
<items>
</items>
    XML
  end

  def test_initial_args
    items = Items.new(
      Item.new(title: "ohai"),
      Item.new(title: "obai")
    )
    assert_equal <<-XML, items.to_xml
<?xml version="1.0" encoding="UTF-8"?>
<items>
  <item>
    <title>ohai</title>
  </item>
  <item>
    <title>obai</title>
  </item>
</items>
    XML
  end
end
