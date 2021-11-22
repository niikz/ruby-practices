# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def test_calc_1
    game_1 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 139, game_1.calc_score
  end

  def test_calc_2
    game_1 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    assert_equal 164, game_1.calc_score
  end

  def test_calc_3
    game_1 = Game.new('0,X,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal 107, game_1.calc_score
  end

  def test_calc_all_zero
    game_1 = Game.new('0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0')
    assert_equal 0, game_1.calc_score
  end

  def test_calc_perfect
    game_1 = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal 300, game_1.calc_score
  end
end
