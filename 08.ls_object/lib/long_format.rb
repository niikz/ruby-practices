#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'entry_status'

class LongFormat
  attr_reader :files

  def initialize(files)
    @files = files
  end

  def create
    total_blocks = 0
    row_data = files.map do |file|
      entry_status = EntryStatus.new(file)
      total_blocks += entry_status.total_block
      entry_status.build_data
    end
    total = "total #{total_blocks}"
    [total, *row_data].join("\n")
  end
end
