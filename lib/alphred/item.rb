require "builder"

require_relative "mods"
require_relative "text"

module Alphred
  class Item
    VALID_TYPES = %i[ default file file_skipcheck ]

    attr_accessor *%i[ uid valid autocomplete title subtitle mods icon arg text ]

    def initialize(title:, **attrs)
      @title = title

      %i[ uid valid autocomplete subtitle arg ].each do |attr|
        self.instance_variable_set("@#{attr}", attrs[attr]) if attrs.has_key?(attr)
      end

      @icon = Icon(attrs[:icon]) if attrs.has_key?(:icon)
      @text = Text.new(attrs[:text]) if attrs.has_key?(:text)
      @mods = Mods.new(attrs[:mods]) if attrs.has_key?(:mods)

      self.type = attrs[:type]
    end

    def type=(type)
      raise ArgumentError.new("`type` must be one of #{VALID_TYPES}") unless type.nil? || VALID_TYPES.include?(type)

      @type = type
    end

    def type
      @type && @type.to_s.gsub(?_, ?:)
    end

    def to_xml(xml=nil)
      xml ||= Builder::XmlMarkup.new(indent: 2)
      xml.item self.attrs do
        xml.title self.title
        xml.subtitle self.subtitle unless self.subtitle.nil?
        self.icon.to_xml(xml) unless self.icon.nil?
        xml.arg self.arg unless self.arg.nil?
        self.mods.to_xml(xml) unless self.mods.nil?
        self.text.to_xml(xml) unless self.text.nil?
      end
    end

    def attrs
      attrs = {}
      %i[ uid autocomplete type ].each do |attr|
        value = self.send(attr)
        attrs[attr] = value unless value.nil?
      end
      attrs[:valid] = (self.valid) ? "yes" : "no" unless self.valid.nil?
      attrs
    end
  end
end