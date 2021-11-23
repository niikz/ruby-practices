#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'long_format'
require_relative 'short_format'

class CommandLineOption
  attr_reader :all_entry, :long_format, :reverse

  def initialize(options)
    @all_entry = options['a']
    @long_format = options['l']
    @reverse = options['r']
  end

  def run_ls
    files = all_entry ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
    files = files.reverse if reverse
    long_format ? display_long_format(files) : display_short_format(files)
  end

  private

  def display_long_format(files)
    long_format = LongFormat.new(files)
    long_format.create
  end

  def display_short_format(files)
    short_format = ShortFormat.new(files)
    short_format.create
  end
end
