#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
  else
    shots << s.to_i
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
