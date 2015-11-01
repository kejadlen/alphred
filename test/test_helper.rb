require "minitest/autorun"

ENV["alfred_workflow_data"] = File.expand_path("..", __FILE__)

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "alphred"

class AlphredTest < Minitest::Test
  include Alphred
end
