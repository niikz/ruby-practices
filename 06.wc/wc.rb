#!/usr/bin/env ruby
# frozen_string_literal: true

def count_file_data
  ARGV.each do |file_name|
    text = File.read(file_name)
    print text.lines.count.to_s.rjust(8)
    print text.split(/\s+|　+/).count.to_s.rjust(8)
    print text.size.to_s.rjust(8)
    puts " #{file_name}"
  end
end

if ARGV[0]
  count_file_data
end
