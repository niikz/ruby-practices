#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

option = ARGV.getopts('l')

def count_file_data(option)
  ARGV.each do |file_name|
    text = File.read(file_name)
    print text.lines.count.to_s.rjust(8)
    unless option['l']
      print text.split(/\s+|　+/).count.to_s.rjust(8)
      print text.size.to_s.rjust(8)
    end
    puts " #{file_name}"
  end
  return unless ARGV.size > 1

  total_file_data(option)
end

def total_file_data(option)
  total_lines = 0
  total_words = 0
  total_bytes = 0
  ARGV.each do |file_name|
    file_read = File.read(file_name)
    total_lines += file_read.lines.count
    total_words += file_read.split(/\s+|　+/).count
    total_bytes += file_read.size
  end
  print total_lines.to_s.rjust(8)
  unless option['l']
    print total_words.to_s.rjust(8)
    print total_bytes.to_s.rjust(8)
  end
  puts ' total'
end

if ARGV[0]
  count_file_data(option)
end
