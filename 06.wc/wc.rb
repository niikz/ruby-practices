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
end

if ARGV[0]
  count_file_data(option)
end
