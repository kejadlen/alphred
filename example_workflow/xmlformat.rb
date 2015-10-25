#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path("../../lib", __FILE__))
require "alphred"
include Alphred

items = Items.new

items << Item.new(uid: "desktop",
                  arg: "~/Desktop",
                  valid: true,
                  autocomplete: "Desktop",



puts items.to_s

<<EOF
<?xml version="1.0"?>

<items>
  <item uid="desktop" arg="~/Desktop" valid="YES" autocomplete="Desktop" type="file">
    <title>Desktop</title>
    <subtitle>~/Desktop</subtitle>
    <icon type="fileicon">~/Desktop</icon>
  </item>

  <item uid="flickr" valid="no" autocomplete="flickr">
    <title>Flickr</title>
    <icon>flickr.png</icon>
  </item>

  <item uid="image" autocomplete="My holiday photo" type="file"> 
    <title>My holiday photo</title> 
    <subtitle>~/Pictures/My holiday photo.jpg</subtitle> 
    <icon type="filetype">public.jpeg</icon> 
  </item>

  <item uid="home" arg="~/" valid="YES" autocomplete="Home" type="file">
    <title>Home Folder</title>
    <icon type="fileicon">~/</icon>
    <subtitle>Home folder ~/</subtitle>
    <subtitle mod="shift">Subtext when shift is pressed</subtitle>
    <subtitle mod="fn">Subtext when fn is pressed</subtitle>
    <subtitle mod="ctrl">Subtext when ctrl is pressed</subtitle>
    <subtitle mod="alt">Subtext when alt is pressed</subtitle>
    <subtitle mod="cmd">Subtext when cmd is pressed</subtitle>
    <text type="copy">Text when copying</text>
    <text type="largetype">Text for LargeType</text>
  </item>

</items>
EOF
