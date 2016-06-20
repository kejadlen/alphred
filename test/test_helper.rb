require 'minitest/autorun'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

class Test < Minitest::Test
  include Alphred
end
