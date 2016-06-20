require_relative '../test_helper'
require 'alphred/text'

class TestText < Test
  def assert_text(expected, text)
    xml = Builder::XmlMarkup.new(indent: 2)
    actual = xml.item { text.to_xml(xml) }
    assert_equal expected, actual
  end

  def test_text
    assert_text <<-XML, Text.new
<item>
</item>
    XML

    assert_text <<-XML, Text.new(copy: "text")
<item>
  <text type="copy">text</text>
</item>
    XML

    assert_text <<-XML, Text.new(largetype: "text")
<item>
  <text type="largetype">text</text>
</item>
    XML

    assert_text <<-XML, Text.new(copy: "copy", largetype: "largetype")
<item>
  <text type="copy">copy</text>
  <text type="largetype">largetype</text>
</item>
    XML
  end
end
