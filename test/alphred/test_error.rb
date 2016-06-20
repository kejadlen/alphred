require_relative '../test_helper'
require 'alphred/error'

class TestError < Test
  class FakeException < StandardError
    attr_reader *%i[ backtrace ]

    def initialize(message, backtrace)
      super(message)

      @backtrace = backtrace
    end
  end

  def test_error
    icon_path = File.expand_path("../../../assets", __FILE__)
    output = <<-OUTPUT
<?xml version="1.0" encoding="UTF-8"?>
<items>
  <item>
    <title>TestError::FakeException: OMG!</title>
    <icon>#{File.join(icon_path, "close.png")}</icon>
  </item>
  <item arg="one">
    <title>...one</title>
    <subtitle>one</subtitle>
    <icon>#{File.join(icon_path, "more.png")}</icon>
  </item>
  <item arg="two">
    <title>...two</title>
    <subtitle>two</subtitle>
    <icon>#{File.join(icon_path, "more.png")}</icon>
  </item>
  <item arg="three">
    <title>...three</title>
    <subtitle>three</subtitle>
    <icon>#{File.join(icon_path, "more.png")}</icon>
  </item>
</items>
    OUTPUT

    assert_output(output) do
      Alphred::Error.try do
        raise FakeException.new("OMG!", %w[ one two three ])
      end
    end
  end
end
