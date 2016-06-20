module Alphred
  class Struct
    def self.attribute(name, **options)
      attributes << Attribute.new(name)
    end

    def self.attributes
      return @attributes if defined?(@attributes)
      @attributes = []
    end

    attr_reader :attributes

    def initialize(**input)
      @attributes = {}
      self.class.attributes.each do |attribute|
        key = attribute.name
        @attributes[key] = input.fetch(key)
      end
    end

    class Attribute
      attr_reader :name

      def initialize(name, **options)
        @name = name
      end
    end
  end
end
