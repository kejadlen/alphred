require_relative "../test_helper"

class TestItem < AlphredTest
  def test_title_required
    assert_raises(ArgumentError) { Item.new }
  end

  def test_blank_item
    item = Item.new(title: "title")
    assert_equal <<-XML, item.to_xml
<item>
  <title>title</title>
</item>
    XML
  end

  def test_attributes
    item = Item.new(title: "title",
                    uid: "uid",
                    arg: "arg",
                    valid: true,
                    autocomplete: "autocomplete",
                    type: :file)
    assert_equal <<-XML, item.to_xml
<item uid="uid" arg="arg" autocomplete="autocomplete" type="file" valid="yes">
  <title>title</title>
</item>
    XML
  end

  def test_invalid_type
    assert_raises(ArgumentError) { item = Item.new(title: "title",
                                                   type: :type) }
  end

  def test_file_skipcheck_type
    item = Item.new(title: "title", type: :file_skipcheck)
    assert_equal <<-XML, item.to_xml
<item type="file:skipcheck">
  <title>title</title>
</item>
    XML
  end

  def test_elements
    item = Item.new(title: "title",
                    subtitle: "subtitle",
                    icon: "icon",
                    text: { copy: "copy", largetype: "largetype" })
    assert_equal <<-XML, item.to_xml
<item>
  <title>title</title>
  <subtitle>subtitle</subtitle>
  <icon>icon</icon>
  <text type="copy">copy</text>
  <text type="largetype">largetype</text>
</item>
    XML
  end

  def test_icon
    item = Item.new(title: "title",
                    icon: { value: "icon", type: :fileicon })
    assert_equal <<-XML, item.to_xml
<item>
  <title>title</title>
  <icon type="fileicon">icon</icon>
</item>
    XML
  end

  def test_subtitle_mods
    item = Item.new(title: "title",
                    mods: { fn: "fn", cmd: "cmd" })
    assert_equal <<-XML, item.to_xml
<item>
  <title>title</title>
  <subtitle mod="fn">fn</subtitle>
  <subtitle mod="cmd">cmd</subtitle>
</item>
    XML
  end
end
