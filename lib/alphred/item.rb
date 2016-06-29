require_relative 'struct'

module Alphred
  class Item < Struct
    attribute :valid, coerce: ->(x) { !!x }
    attribute :uid
    attribute :type,
      coerce: ->(x) { x.to_s.gsub(?_, ?:) },
      enum: %w[ default file file:skipcheck ]
    attribute :title, required: true
    attribute :subtitle
    attribute :arg
    attribute :autocomplete
    attribute :icon, coerce: ->(x) { Icon(x) }
    attribute :quicklookurl
    attribute :mods, coerce: ->(x) { Mods.new(x) }
    attribute :text, coerce: ->(x) { Text.new(x) }
  end

  class Icon < Struct
    attribute :type, enum: %i[ fileicon filetype ]
    attribute :path, required: true
  end

  class Mod < Struct
    attribute :valid, coerce: ->(x) { !!x }
    attribute :arg
    attribute :subtitle
  end

  class Mods < Struct
    attribute :ctrl, coerce: ->(x) { Mod.new(x) }
    attribute :alt, coerce: ->(x) { Mod.new(x) }
    attribute :cmd, coerce: ->(x) { Mod.new(x) }
    attribute :fn, coerce: ->(x) { Mod.new(x) }
    attribute :shift, coerce: ->(x) { Mod.new(x) }
  end

  class Text < Struct
    attribute :copy
    attribute :largetype
  end
end

module Kernel
  def Icon(arg)
    case arg
    when Alphred::Icon then arg
    when String        then Alphred::Icon.new(path: arg)
    when Hash          then Alphred::Icon.new(**arg)
    end
  end
end
