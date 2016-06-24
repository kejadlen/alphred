require_relative 'test_helper'
require 'alphred'

require 'json'

class TestAlphred < Test
  def test_alphred
    items = Items[
      Item.new(
        uid: 'desktop',
        type: 'file',
        title: 'Desktop',
        subtitle: '~/Desktop',
        arg: '~/Desktop',
        autocomplete: 'Desktop',
        icon: { type: :fileicon, path: '~/Desktop' },
      ),
      Item.new(
        valid: false,
        uid: 'flickr',
        title: 'Flickr',
        icon: 'flickr.png'
      ),
      Item.new(
        uid: 'image',
        type: 'file',
        title: 'My holiday photo',
        subtitle: '~/Pictures/My holiday photo.jpg',
        autocomplete: 'My holiday photo',
        icon: { type: :filetype, path: 'public.jpeg' },
      ),
      Item.new(
        valid: false,
        uid: 'alfredapp',
        title: 'Alfred Website',
        subtitle: 'https://www.alfredapp.com/',
        arg: 'alfredapp.com',
        autocomplete: 'Alfred Website',
        quicklookurl: 'https://www.alfredapp.com/',
        mods: {
          alt: {
            valid: true,
            arg: 'alfredapp.com/powerpack',
            subtitle: 'https://www.alfredapp.com/powerpack/',
          },
          cmd: {
            valid: true,
            arg: 'alfredapp.com/powerpack/buy/',
            subtitle: 'https://www.alfredapp.com/powerpack/buy/',
          },
        },
        text: {
          copy: 'https://www.alfredapp.com/ (text here to copy)',
          largetype: 'https://www.alfredapp.com/ (text here for large type)',
        },
      ),
    ]
    assert_equal <<-JSON.chomp, JSON.pretty_generate(items)
{
  "items": [
    {
      "uid": "desktop",
      "type": "file",
      "title": "Desktop",
      "subtitle": "~/Desktop",
      "arg": "~/Desktop",
      "autocomplete": "Desktop",
      "icon": {
        "type": "fileicon",
        "path": "~/Desktop"
      }
    },
    {
      "valid": false,
      "uid": "flickr",
      "title": "Flickr",
      "icon": {
        "path": "flickr.png"
      }
    },
    {
      "uid": "image",
      "type": "file",
      "title": "My holiday photo",
      "subtitle": "~/Pictures/My holiday photo.jpg",
      "autocomplete": "My holiday photo",
      "icon": {
        "type": "filetype",
        "path": "public.jpeg"
      }
    },
    {
      "valid": false,
      "uid": "alfredapp",
      "title": "Alfred Website",
      "subtitle": "https://www.alfredapp.com/",
      "arg": "alfredapp.com",
      "autocomplete": "Alfred Website",
      "quicklookurl": "https://www.alfredapp.com/",
      "mods": {
        "alt": {
          "valid": true,
          "arg": "alfredapp.com/powerpack",
          "subtitle": "https://www.alfredapp.com/powerpack/"
        },
        "cmd": {
          "valid": true,
          "arg": "alfredapp.com/powerpack/buy/",
          "subtitle": "https://www.alfredapp.com/powerpack/buy/"
        }
      },
      "text": {
        "copy": "https://www.alfredapp.com/ (text here to copy)",
        "largetype": "https://www.alfredapp.com/ (text here for large type)"
      }
    }
  ]
}
    JSON
  end
end
