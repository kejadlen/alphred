require_relative "../test_helper"

class TestConfig < AlphredTest
  def test_load
    config = Config.load(foo: "bar", baz: "qux")

    assert_equal "bar", config[:foo]
    assert_equal "quux", config[:baz]
  end

  def test_filter_xml
    config = Config.load(foo: "bar", baz: "qux")

    assert_equal <<-XML, config.filter_xml
<?xml version="1.0" encoding="UTF-8"?>
<items>
  <item uid="foo" arg="{&quot;foo&quot;:&quot;&quot;}">
    <title>Unset foo</title>
    <subtitle>bar</subtitle>
  </item>
  <item uid="baz" arg="{&quot;baz&quot;:&quot;&quot;}">
    <title>Unset baz</title>
    <subtitle>quux</subtitle>
  </item>
</items>
    XML

    assert_equal <<-XML, config.filter_xml("qux")
<?xml version="1.0" encoding="UTF-8"?>
<items>
  <item uid="foo" arg="{&quot;foo&quot;:&quot;qux&quot;}">
    <title>Set foo to qux</title>
    <subtitle>bar</subtitle>
  </item>
  <item uid="baz" arg="{&quot;baz&quot;:&quot;qux&quot;}">
    <title>Set baz to qux</title>
    <subtitle>quux</subtitle>
  </item>
</items>
    XML
  end
end
