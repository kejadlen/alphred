require 'json'

module Alphred
  class Struct
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

        attrs[attr.name] = attr.coerce.call(input.fetch(attr.name))
      end
    end

    def to_json(options=nil)
      attributes.to_json(options)
    end

    class Attribute
      attr_reader :name, :coerce

      def initialize(name, **options)
        @name = name
        @required = options.fetch(:required, false)
        @coerce = options.fetch(:coerce, ->(x) { x })
      end

      def required?
        @required
      end
    end
  end
end
