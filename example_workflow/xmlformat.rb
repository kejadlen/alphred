#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.expand_path("../vendor/bundle", __FILE__))
require "bundler/setup"
require "alphred"

puts <<EOF
<?xml version="1.0"?>

<items>

<!--
  Example of using icon type 'fileicon' to load the file icon directly.
  This item is of type "file" which means it will be treated as a file in
  Alfred's results, so can be actioned and revealed in finder.
  Autocomplete sets what will complete when the user autocompletes.
-->

  <item uid="desktop" arg="~/Desktop" valid="YES" autocomplete="Desktop" type="file">
    <title>Desktop</title>
    <subtitle>~/Desktop</subtitle>
    <icon type="fileicon">~/Desktop</icon>
  </item>

<!--
  Example of loading an icon from the Workflow's folder.
  This item is set as valid no, which means it won't be actioned
-->

  <item uid="flickr" valid="no" autocomplete="flickr">
    <title>Flickr</title>
    <icon>flickr.png</icon>
  </item>

<!--
  Example of using icon type 'filetype' to load the icon for the file type.
  This item is of type "file" which means it will be treated as a file in
  Alfred's results, so can be actioned and revealed in finder.
-->

  <item uid="image" autocomplete="My holiday photo" type="file"> 
    <title>My holiday photo</title> 
    <subtitle>~/Pictures/My holiday photo.jpg</subtitle> 
    <icon type="filetype">public.jpeg</icon> 
  </item>

<!--
  Example of using of the new XML features from Alfred 2.3 onwards. The
  ability to define some dynamic alternative modifier subtexts as well
  as define the text used for ⌘C copying and ⌘L large type.

  Subtitle modifiers can be shift, fn, ctrl, alt, cmd and will only show
  the relevant modified output connection is made.
-->

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
