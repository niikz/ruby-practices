#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  options = ARGV.getopts('alr')
  dir_file = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
  dir_file = dir_file.reverse if options['r']
  if options['l']
    long_format(dir_file)
  else
    multiple_columns(dir_file)
  end
end

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

def convert_to_ftype(ftype)
  {
    file: '-',
    directory: 'd',
    characterSpecial: 'c',
    blockSpecial: 'b',
    fifo: 'p',
    link: 'l',
    socket: 's'
  }[ftype.to_sym]
end

def convert_to_mode(mode)
  {
    '7': 'rwx',
    '6': 'rw-',
    '5': 'r-x',
    '4': 'r--',
    '3': '-wx',
    '2': '-w-',
    '1': '--x',
    '0': '---'
  }[mode.to_sym]
end

def file_status(file)
  file_stat = File::Stat.new(file)
  stat_mode = file_stat.mode.to_s(8)[-3, 3].split('').map { |f| convert_to_mode(f) }
  data = []
  data << convert_to_ftype(file_stat.ftype) + stat_mode.join
  data << file_stat.nlink.to_s.rjust(2, ' ')
  data << Etc.getpwuid(file_stat.uid).name
  data << Etc.getgrgid(file_stat.gid).name.rjust(6, ' ')
  data << file_stat.size.to_s.rjust(5, ' ')
  data << file_stat.mtime.strftime('%_m %_d %R')
  data << file
end

def long_format(dir_file)
  total_block = 0
  dir_file.each do |file|
    total_block += File::Stat.new(file).blocks
  end
  puts "total #{total_block}"

  dir_file.each do |file|
    puts file_status(file).join(' ')
  end
end

main
