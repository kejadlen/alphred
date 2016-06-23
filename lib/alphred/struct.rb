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
      validate_input(input)

      @attributes = self.class.attributes.select { |attr|
        attr.required? || input.keys.include?(attr.name)
      }.reduce({}) { |hash, attr|
        hash.merge(attr.value_from(input))
      }
    end

    def to_json(options=nil)
      attributes.to_json(options)
    end

    private

    def validate_input(input)
      attribute_names = self.class.attributes.map(&:name)
      invalid_keys = input.keys.reject {|key| attribute_names.include?(key) }
      unless invalid_keys.empty?
        msg = "Invalid attribute(s): #{invalid_keys.join(', ')}"
        raise InvalidAttributeError.new(msg)
      end
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
        !!@required
      end

      def value_from(hash)
        uncoerced = hash.fetch(name) { raise RequiredAttributeError.new(name) }
        coerced = coerce.call(uncoerced)
        raise InvalidEnumError.new(coerced) if enum && !enum.include?(coerced)
        { name => coerced }
      end
    end
  end
end
