require_relative '../test_helper'
require 'alphred/mods'

class TestMods < Test
  def assert_mods(expected, mods)
    xml = Builder::XmlMarkup.new(indent: 2)
    actual = xml.item { mods.to_xml(xml) }
    assert_equal expected, actual
  end

  def test_mods
    assert_mods <<-XML, Mods.new
<item>
</item>
    XML

    assert_mods <<-XML, Mods.new(shift: "shift")
<item>
  <subtitle mod="shift">shift</subtitle>
</item>
    XML

    assert_mods <<-XML, Mods.new(cmd: "cmd")
<item>
  <subtitle mod="cmd">cmd</subtitle>
</item>
    XML

    assert_mods <<-XML, Mods.new(fn: "fn", alt: "alt")
<item>
  <subtitle mod="fn">fn</subtitle>
  <subtitle mod="alt">alt</subtitle>
</item>
    XML
  end
end
