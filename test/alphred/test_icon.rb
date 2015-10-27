require_relative "../test_helper"

class TestIcon < AlphredTest
  def test_icon
    icon = Icon.new(value: "value")
    assert_equal <<-XML, icon.to_xml
<icon>value</icon>
    XML
  end

  def test_type
    icon = Icon.new(value: "value", type: :fileicon)
    assert_equal <<-XML, icon.to_xml
<icon type="fileicon">value</icon>
    XML
  end

  def test_invalid_type
    assert_raises(ArgumentError) { Icon.new(value: "value", type: :type) }
  end

  def test_cast
    icon = Icon.new(value: "value")
    assert_equal icon, Icon(icon)

    assert_equal "value", Icon("value").value

    assert_equal :fileicon, Icon(value: "value", type: :fileicon).type
  end
end
