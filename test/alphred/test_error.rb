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
    icon_path = File.expand_path('../../../assets', __FILE__)
    output = <<-OUTPUT.chomp
{"items":[{"title":"TestError::FakeException: OMG!","icon":{"path":"#{File.join(icon_path, 'close.png')}"}},{"title":"...one","subtitle":"one","arg":"one","icon":{"path":"#{File.join(icon_path, 'more.png')}"}},{"title":"...two","subtitle":"two","arg":"two","icon":{"path":"#{File.join(icon_path, 'more.png')}"}},{"title":"...three","subtitle":"three","arg":"three","icon":{"path":"#{File.join(icon_path, 'more.png')}"}}]}
    OUTPUT

    assert_output(output) do
      Alphred::Error.try do
        raise FakeException.new('OMG!', %w[ one two three ])
      end
    end
  end
end
