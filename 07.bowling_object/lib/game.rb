#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def convert_to_shots(mark)
    mark.split(',')
  end

  def divide_into_frames(mark)
    shots = convert_to_shots(mark)
    frames = shots.first(9).map do
      shots.first == 'X' ? shots.shift(1) : shots.shift(2)
    end
    frames << shots
  end

  def create_frame(mark)
    frames = divide_into_frames(mark)
    frames.map do |f|
      Frame.new(f[0], f[1], f[2])
    end
  end

  def calc_score
    points = 0
    frames = create_frame(mark)
    frames.each_with_index do |frame, index|
      points += frame.score
      points += first_bonus_point(frames, index)
    end
    points
  end

  def next_frame(frame, index)
    frame[index + 1]
  end

  def first_bonus_point(frame, index)
    next_frame = next_frame(frame, index)
    next_frame.first_shot.score
  end
end
