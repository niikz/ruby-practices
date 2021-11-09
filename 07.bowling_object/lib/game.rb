#!/usr/bin/env ruby
# frozen_string_literal: true

class Game
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def convert_to_shots
    mark.split(',')
  end
end

game_1 = Game.new('1,8,2,7,3,6,4,5,0,9,1,8,2,7,3,6,4,5,0,9')
p game_1.convert_to_shots
