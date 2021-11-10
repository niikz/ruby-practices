#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/game'

score = ARGV[0]
game = Game.new(score)
puts game.calc_score
