require_relative '../test_helper'
require 'alphred/struct'

class TestStruct < Minitest::Test
  class Foo < Alphred::Struct
    attribute :name
    attribute :address, optional: true
    attribute :age, optional: true, coerce: ->(x) { x.to_i }
  end

  def test_attributes
    assert_equal %i[ name address age ], Foo.attributes.map(&:name)

    foo = Foo.new(name: 'Bob')
    assert_equal({ name: 'Bob' }, foo.attributes)
    assert_equal 'Bob', foo.name
  end

  def test_required
    assert_raises { Foo.new }
  end

  def test_optional
    foo = Foo.new(name: 'Bob', address: '123 Main St')
    assert_equal '123 Main St', foo.address
  end

  def test_coerce
    foo = Foo.new(name: 'Bob', age: '123')
    assert_equal 123, foo.age
  end
end
