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

  def test_strike
    frame_1 = Frame.new('X')
    assert_equal 10, frame_1.score
    assert frame_1.strike?
  end

  def test_spare
    frame_1 = Frame.new('1', '9')
    assert_equal 10, frame_1.score
    assert frame_1.spare?

    frame_2 = Frame.new('0', 'X')
    assert_equal 10, frame_2.score
    assert frame_2.spare?
  end
end
