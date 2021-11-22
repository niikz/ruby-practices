# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/shot'

class ShotTest < Minitest::Test
  def test_shot
    shot_1 = Shot.new('X')
    assert_equal "X", shot_1.mark
    assert_equal 10, shot_1.score

    shot_2 = Shot.new(0)
    assert_equal 0, shot_2.mark
    assert_equal 0, shot_2.score
  end
end
