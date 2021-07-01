#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

def main
  options = ARGV.getopts('alr')
  files = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
  files = files.reverse if options['r']
  if options['l']
    long_format(files)
  else
    display_format(files)
  end
end

COLUMN_SIZE = 3
def display_format(files)
  max_lines = (files.size.to_f / COLUMN_SIZE).ceil
  sliced_array = files.each_slice(max_lines).to_a
  if sliced_array.last.size < max_lines
    number_of_blanks = max_lines - sliced_array.last.size
    number_of_blanks.times { sliced_array.last.push('') }
  end
  transposed_array = sliced_array.transpose
  max_characters = files.map(&:size).max
  show_array(transposed_array, max_characters)
end

def show_array(transposed_array, max_characters)
  transposed_array.each do |array|
    array.each do |a|
      print a.ljust(max_characters)
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

def long_format(files)
  total_block = 0
  data_array = []
  files.each do |file|
    file_stat = File.stat(file)
    total_block += file_stat.blocks
    stat_mode = file_stat.mode.to_s(8)[-3, 3].split('').map { |f| convert_to_mode(f) }
    data = [
      convert_to_ftype(file_stat.ftype) + stat_mode.join,
      file_stat.nlink.to_s.rjust(2),
      Etc.getpwuid(file_stat.uid).name,
      Etc.getgrgid(file_stat.gid).name.rjust(6),
      file_stat.size.to_s.rjust(5),
      file_stat.mtime.strftime('%_m %_d %R'),
      file
    ].join(' ')
    data_array << data
  end
  puts "total #{total_block}"
  puts data_array
end

main
