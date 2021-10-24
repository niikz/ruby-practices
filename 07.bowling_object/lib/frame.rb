#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def score
    [first_shot.score, second_shot.score, third_shot.score].sum
  end
end

frame_1 = Frame.new('1', '9', '8')
p frame_1.score

frame_2 = Frame.new('5', '2')
p frame_2.score
