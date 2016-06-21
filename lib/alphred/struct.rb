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
        next if attr.optional? && !input.has_key?(attr.name)

        attrs[attr.name] = input.fetch(attr.name)
      end
    end

    class Attribute
      attr_reader :name

      def initialize(name, **options)
        @name = name
        @optional = options.fetch(:optional, false)
      end

      def optional?
        !!@optional
      end
    end
  end
end
