# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/frame'

class FrameTest < Minitest::Test
  def test_frame
    frame_1 = Frame.new('1', '9', '8')
    assert_equal 18, frame_1.score

    frame_2 = Frame.new('5', '2')
    assert_equal 7, frame_2.score
  end
end
