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
