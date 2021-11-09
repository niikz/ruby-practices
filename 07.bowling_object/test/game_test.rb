# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def test_game_1
    game_1 = Game.new('1,8,2,7,3,6,4,5,0,9,1,8,2,7,3,6,4,5,0,9')
    assert_equal ["1", "8", "2", "7", "3", "6", "4", "5", "0", "9", "1", "8", "2", "7", "3", "6", "4", "5", "0", "9"], game_1.convert_to_shots
    assert_equal [["1", "8"], ["2", "7"], ["3", "6"], ["4", "5"], ["0", "9"], ["1", "8"], ["2", "7"], ["3", "6"], ["4", "5"], ["0", "9"]], game_1.divide_into_frames
    assert_equal 90, game_1.frame_score
  end

  def test_game_2
    game_2 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal ["6", "3", "9", "0", "0", "3", "8", "2", "7", "3", "X", "9", "1", "8", "0", "X", "6", "4", "5"], game_2.convert_to_shots
    assert_equal [["6", "3"], ["9", "0"], ["0", "3"], ["8", "2"], ["7", "3"], ["X"], ["9", "1"], ["8", "0"], ["X"], ["6", "4", "5"]], game_2.divide_into_frames
    assert_equal 94, game_2.frame_score
  end
end
