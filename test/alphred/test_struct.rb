require_relative '../test_helper'
require 'alphred/struct'

class TestStruct < Minitest::Test
  class Foo < Alphred::Struct
    attribute :name
    attribute :address, optional: true
  end

  def test_attributes
    assert_equal %i[ name address ], Foo.attributes.map(&:name)

    foo = Foo.new(name: 'Bob')
    assert_equal({ name: 'Bob' }, foo.attributes)
    assert_equal 'Bob', foo.name

    foo = Foo.new(name: 'Bob', address: '123 Main St')
    assert_equal({ name: 'Bob', address: '123 Main St' }, foo.attributes)
    assert_equal '123 Main St', foo.address
  end

  def test_required_attribute
    assert_raises { Foo.new }
  end
end
