#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = ARGV.getopts('alr')

dir_file = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort

COLUMN_SIZE = 3
def multiple_columns(dir_file)
  max_lines = (dir_file.size.to_f / COLUMN_SIZE).ceil
  sliced_array = dir_file.each_slice(max_lines).map { |d| d }
  (max_lines - sliced_array.last.size).times { sliced_array.last.push('') } if sliced_array.last.size < max_lines
  transposed_array = sliced_array.transpose
  max_characters = dir_file.map(&:size).max
  print_transposed_array(transposed_array, max_characters)
end

def print_transposed_array(transposed_array, max_characters)
  transposed_array.each do |array|
    array.each do |a|
      print a.ljust(max_characters, ' ')
      print("\t")
    end
    print("\n")
  end
end

if options['l']
  long_format(dir_file)
else
  multiple_columns(dir_file)
end
