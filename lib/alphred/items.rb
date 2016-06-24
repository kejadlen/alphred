require 'delegate'

require 'json'

module Alphred
  class Items < DelegateClass(Array)
    def self.[](*args)
      new(*args)
    end

    attr_reader :items

    def initialize(*items)
      @items = items
      super(@items)
    end

    def to_json(options=nil)
      { items: items }.to_json(options)
    end
  end
end
