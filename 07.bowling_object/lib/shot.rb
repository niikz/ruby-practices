#!/usr/bin/env ruby
# frozen_string_literal: true

class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def score
    return 10 if mark == 'X'

    mark.to_i
  end
end

shot_1 = Shot.new('X')
p shot_1.mark
p shot_1.score

shot_2 = Shot.new(1)
p shot_2.mark
p shot_2.score
