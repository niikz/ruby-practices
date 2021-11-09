#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def convert_to_shots
    @shots = mark.split(',')
  end

  def divide_into_frames
    @frames = @shots.first(9).map do
      @shots.first == 'X' ? @shots.shift(1) : @shots.shift(2)
    end
    @frames << @shots
  end

  def frame_score
    points = @frames.map do |f|
      frame = Frame.new(f[0], f[1], f[2])
      frame.score
    end
    points.sum
  end
end
