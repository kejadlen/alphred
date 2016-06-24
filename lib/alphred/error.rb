require_relative 'item'
require_relative 'items'

require 'json'

module Alphred
  class Error < StandardError
    ASSETS = File.expand_path('../../../assets', __FILE__)

    def self.try
      yield
    rescue Exception => e
      print self.new(e).to_json
    end

    attr_reader :error

    def initialize(error)
      @error = error
    end

    def to_json(options=nil)
      to_items.to_json(options)
    end

    def to_items
      icon = File.join(ASSETS, 'close.png')
      items = [ Alphred::Item.new(title: "#{self.error.class}: #{self.error}",
                                  icon: icon) ]
      items.concat(self.backtrace_items)
      Items[*items]
    end

    def backtrace_items
      icon = File.join(ASSETS, 'more.png')

      base_dirs = $LOAD_PATH + [ENV['alfred_preferences']]
      to_delete = /^#{base_dirs.join(?|)}/

      self.error.backtrace.map { |line|
        title = line.sub(to_delete, '...')
        Item.new(
          title: title,
          subtitle: line,
          arg: line,
          icon: icon,
        )
      }
    end
  end
end
