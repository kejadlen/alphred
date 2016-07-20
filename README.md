# Alphred

Alphred is a library for making Alfred workflows in Ruby. It's designed
specifically for how I work, so assumes that you manage dependencies with
[Bundler][bundler] and Rubies with [chruby][chruby].

[bundler]: http://bundler.io/
[chruby]: https://github.com/postmodern/chruby

## Usage

The [example script filter][scriptfilter] would look like this using Alphred:

[scriptfilter]: https://www.alfredapp.com/help/workflows/inputs/script-filter/

``` ruby
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
items.to_json
```

This produces the following JSON:

``` json
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
```

### Releasing

Including `alphred/tasks` in your `Rakefile` will allow access to Alphred's
Rake tasks for releasing a workflow. `release` will tag the current commit with
the provided version and create a .alfredworkflow package with vendored gem
dependencies.

## Development

After checking out the repo, run `bundle install` to install dependencies.
Then, run `rake test` to run the tests. You can also run `rake console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/kejadlen/alphred. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).

## Credits

- [Close]() by Berkay Sargın from the Noun Project
