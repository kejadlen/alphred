require 'json'

module Alphred
  class Struct
    class RequiredAttributeError < StandardError; end
    class InvalidEnumError < StandardError; end
    class InvalidAttributeError < StandardError; end

    def self.attribute(name, **options)
      attributes << Attribute.new(name, **options)

      define_method(name) do
        attributes[name]
      end
    end

    def self.attributes
      return @attributes if defined?(@attributes)
      @attributes = []
    end

    attr_reader :attributes

    def initialize(**input)
      @attributes = self.class.attributes.each.with_object({}) do |attr, attrs|
        next unless attr.required? || input.has_key?(attr.name)

        value = input.delete(attr.name) {
          raise RequiredAttributeError.new(attr.name)
        }
        coerced = attr.coerce.call(value)
        raise InvalidEnumError.new(coerced) if attr.enum && !attr.enum.include?(coerced)
        attrs[attr.name] = coerced
      end

      raise InvalidAttributeError.new(input.keys.join(', ')) unless input.empty?
    end

    def to_json(options=nil)
      attributes.to_json(options)
    end

    class Attribute
      attr_reader :name, :coerce, :enum

      def initialize(name, **options)
        @name = name
        @required = options.fetch(:required, false)
        @coerce = options.fetch(:coerce, ->(x) { x })
        @enum = options[:enum]
      end

      def required?
        @required
      end
    end
  end
end
