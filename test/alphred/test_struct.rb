require_relative '../test_helper'
require 'alphred/struct'

class TestStruct < Minitest::Test
  class Foo < Alphred::Struct
    attribute :name
    attribute :address, optional: true
  end

  def setup
    @foo = Foo.new(name: 'Bob')
  end

  def test_attributes
    assert_equal %i[ name address ], Foo.attributes.map(&:name)
    assert_equal({ name: 'Bob' }, @foo.attributes)
  end

  def test_required_attribute
    assert_raises { Foo.new }
  end
end
