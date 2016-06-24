require_relative '../test_helper'
require 'alphred/items'

require 'json'

require 'alphred/item'

class TestItems < Test
  def test_brackets
    items = Items[]
    assert_equal Items.new, items
  end

  def test_empty
    items = Items.new
    assert_equal <<-JSON.chomp, JSON.pretty_generate(items)
{
  "items": [

  ]
}
    JSON
  end

  def test_initial_args
    items = Items.new(
      Item.new(title: 'ohai'),
      Item.new(title: 'obai')
    )
    assert_equal <<-JSON.chomp, JSON.pretty_generate(items)
{
  "items": [
    {
      "title": "ohai"
    },
    {
      "title": "obai"
    }
  ]
}
    JSON
  end
end
