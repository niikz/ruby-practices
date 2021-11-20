#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_reader :mark

  def initialize(mark)
    @mark = mark
    @frames = create_frame(mark)
  end

  def calc_score
    @frames.each_with_index.sum do |frame, index|
      points = 0
      points += frame.score
      unless last_frame?(index)
        points += strike_point(@frames, index) if frame.strike?
        points += spare_point(@frames, index) if frame.spare?
      end
      points
    end
  end

  private

  def convert_to_shots(mark)
    mark.split(',')
  end

  def shots_per_frame(mark)
    shots = convert_to_shots(mark)
    frames = shots.first(9).map do
      shots.first == 'X' ? shots.shift(1) : shots.shift(2)
    end
    frames << shots
  end

  def create_frame(mark)
    frames = shots_per_frame(mark)
    frames.map do |f|
      Frame.new(f[0], f[1], f[2])
    end
  end

  def last_frame?(index)
    index == 9
  end

  def next_frame(frame, index)
    frame[index + 1]
  end

  def spare_point(frame, index)
    first_bonus_point(frame, index)
  end

  def strike_point(frame, index)
    first_bonus_point(frame, index) + second_bonus_point(frame, index)
  end

  def first_bonus_point(frame, index)
    next_frame = next_frame(frame, index)
    next_frame.first_shot.score
  end

  def second_bonus_point(frame, index)
    next_frame = next_frame(frame, index)
    two_ahead_frame = next_frame(frame, index + 1)
    if next_frame.strike?
      index == 8 ? next_frame.second_shot.score : two_ahead_frame.first_shot.score
    else
      next_frame.second_shot.score
    end
  end
end
