require_relative '../test_helper'
require 'alphred/struct'

require 'json'

class TestStruct < Minitest::Test
  class Foo < Alphred::Struct
    attribute :name, required: true
    attribute :address
    attribute :age, coerce: ->(x) { x.to_i }
    attribute :state, enum: %i[ VA WA ]
  end

  def test_attributes
    assert_equal %i[ name address age state ], Foo.attributes.map(&:name)

    foo = Foo.new(name: 'Bob')
    assert_equal({ name: 'Bob' }, foo.attributes)
    assert_equal 'Bob', foo.name
  end

  def test_required
    assert_raises(Alphred::Struct::RequiredAttributeError) {
      Foo.new(address: '123 Main St')
    }
  end

  def test_optional
    foo = Foo.new(name: 'Bob', address: '123 Main St')
    assert_equal '123 Main St', foo.address
  end

  def test_coerce
    foo = Foo.new(name: 'Bob', age: '123')
    assert_equal 123, foo.age
  end

  def test_enum
    foo = Foo.new(name: 'Bob', state: :WA)
    assert_equal :WA, foo.state

    assert_raises(Alphred::Struct::InvalidEnumError) {
      Foo.new(name: 'Bob', state: :WV)
    }
  end

  def test_invalid_attributes
    assert_raises(Alphred::Struct::InvalidAttributeError) {
      Foo.new(name: 'Bob', addr: '123 Main St')
    }
  end

  def test_json
    foo = Foo.new(name: 'Bob')
    assert_equal <<-JSON.chomp, JSON.pretty_generate(foo)
{
  "name": "Bob"
}
    JSON

    foo = Foo.new(name: 'Bob', address: '123 Main St', age: '123')
    assert_equal <<-JSON.chomp, JSON.pretty_generate(foo)
{
  "name": "Bob",
  "address": "123 Main St",
  "age": 123
}
    JSON
  end
end
