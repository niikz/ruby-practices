#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = scores.map do |s|
  if s == 'X'
    10
  else
    s.to_i
  end
end

frames = []
frame = []
shots.each do |s|
  frame << s
  if frames.size < 9 && (frame.size == 2 || (frame.size == 1 && s == 10))
    frames << frame
    frame = []
  elsif frames.size >= 9
    if frame.sum >= 10 && frame.size == 3
      frames << frame
    elsif frame.sum < 10 && frame.size == 2
      frames << frame
    end
  end
end

point = 0
frames.each_with_index do |(first_throw, second_throw, third_throw), i|
  frame_sum = first_throw.to_i + second_throw.to_i + third_throw.to_i
  next_frame = frames[i + 1]
  two_ahead_frame = frames[i + 2]
  if i <= 8
    next_frame_first = next_frame[0].to_i
    next_frame_second = next_frame[1].to_i
    if first_throw == 10 # strike
      if i <= 7 && next_frame_first == 10
        two_ahead_frame_first = two_ahead_frame[0].to_i
        point += frame_sum + next_frame_first + two_ahead_frame_first
      else
        point += frame_sum + next_frame_first + next_frame_second
      end
    elsif frame_sum == 10 # spare
      point += frame_sum + next_frame_first
    else
      point += frame_sum
    end
  elsif i > 8
    point += frame_sum
  end
end
puts point
