#!/usr/bin/env ruby
# frozen_string_literal: true

class ShortFormat
  attr_reader :files

  def initialize(files)
    @files = files
  end

  COLUMN_SIZE = 3

  def create
    max_lines = (files.size.to_f / COLUMN_SIZE).ceil
    sliced_rows = files.each_slice(max_lines).to_a
    if sliced_rows.last.size < max_lines
      number_of_blanks = max_lines - sliced_rows.last.size
      number_of_blanks.times { sliced_rows.last.push('') }
    end
    transposed_rows = sliced_rows.transpose
    max_characters = files.map(&:size).max
    format_table(transposed_rows, max_characters)
  end

  def format_table(transposed_rows, max_characters)
    transposed_rows.each do |row_files|
      format_short_rows(row_files, max_characters)
      print("\n")
    end
  end

  def format_short_rows(row_files, max_characters)
    row_files.each do |row|
      print row.ljust(max_characters)
      print("\t")
    end
  end
end
