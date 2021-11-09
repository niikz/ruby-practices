# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def test_game
    game_1 = Game.new('1,8,2,7,3,6,4,5,0,9,1,8,2,7,3,6,4,5,0,9')
    assert_equal ["1", "8", "2", "7", "3", "6", "4", "5", "0", "9", "1", "8", "2", "7", "3", "6", "4", "5", "0", "9"], game_1.convert_to_shots
  end
end
