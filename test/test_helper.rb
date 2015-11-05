require "minitest/autorun"

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "alphred"

class AlphredTest < Minitest::Test
  include Alphred
end
