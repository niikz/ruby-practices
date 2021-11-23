#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_info'

class LongFormat
  attr_reader :files

  def initialize(files)
    @files = files
  end

  def create
    total_blocks = 0
    data_array = []
    files.each do |file|
      @file_info = FileInfo.new(file)
      total_blocks += @file_info.total_block
      data_array << @file_info.data
    end
    puts "total #{total_blocks}"
    puts data_array
  end
end
