require_relative "test_helper"

require "alphred"

class TestAlphred < Minitest::Test
  def test_alphred
    items = Alphred::Items.new
    items << Alphred::Item.new(uid: "desktop",
                               arg: "~/Desktop",
                               valid: true,
                               autocomplete: "Desktop",
                               type: :file,
                               title: "Desktop",
                               subtitle: "~/Desktop",
                               icon: { value: "~/Desktop", type: :fileicon })
    items << Alphred::Item.new(uid: "flickr",
                               valid: false,
                               autocomplete: "flickr",
                               title: "Flickr",
                               icon: "flickr.png")
    items << Alphred::Item.new(uid: "image",
                               autocomplete: "My holiday photo",
                               type: :file,
                               title: "My holiday photo",
                               subtitle: "~/Pictures/My holiday photo.jpg",
                               icon: { value: "public.jpeg", type: :filetype })
    items << Alphred::Item.new(uid: "home",
                               arg: "~/",
                               valid: true,
                               autocomplete: "Home",
                               type: :file,
                               title: "Home Folder",
                               subtitle: "Home folder ~/",
                               icon: { value: "~/", type: :fileicon },
                               mods: { shift: "Subtext when shift is pressed",
                                       fn: "Subtext when fn is pressed",
                                       ctrl: "Subtext when ctrl is pressed",
                                       alt: "Subtext when alt is pressed",
                                       cmd: "Subtext when cmd is pressed" },
                               text: { copy: "Text when copying",
                                       largetype: "Text for LargeType" })
    assert_equal <<-XML, items.to_xml
<?xml version="1.0" encoding="UTF-8"?>
<items>
  <item uid="desktop" arg="~/Desktop" autocomplete="Desktop" type="file" valid="yes">
    <title>Desktop</title>
    <subtitle>~/Desktop</subtitle>
    <icon type="fileicon">~/Desktop</icon>
  </item>
  <item uid="flickr" autocomplete="flickr" valid="no">
    <title>Flickr</title>
    <icon>flickr.png</icon>
  </item>
  <item uid="image" autocomplete="My holiday photo" type="file">
    <title>My holiday photo</title>
    <subtitle>~/Pictures/My holiday photo.jpg</subtitle>
    <icon type="filetype">public.jpeg</icon>
  </item>
  <item uid="home" arg="~/" autocomplete="Home" type="file" valid="yes">
    <title>Home Folder</title>
    <subtitle>Home folder ~/</subtitle>
    <icon type="fileicon">~/</icon>
    <subtitle mod="shift">Subtext when shift is pressed</subtitle>
    <subtitle mod="fn">Subtext when fn is pressed</subtitle>
    <subtitle mod="ctrl">Subtext when ctrl is pressed</subtitle>
    <subtitle mod="alt">Subtext when alt is pressed</subtitle>
    <subtitle mod="cmd">Subtext when cmd is pressed</subtitle>
    <text type="copy">Text when copying</text>
    <text type="largetype">Text for LargeType</text>
  </item>
</items>
    XML
  end
end
