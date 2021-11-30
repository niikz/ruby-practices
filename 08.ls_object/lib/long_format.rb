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
    row_data = files.map do |file|
      file_info = FileInfo.new(file)
      total_blocks += file_info.total_block
      file_info.data
    end
    total = "total #{total_blocks}"
    [total, *row_data].join("\n")
  end
end
