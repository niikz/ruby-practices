#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

options = ARGV.getopts('alr')

dir_file = options['a'] ? Dir.glob('*', File::FNM_DOTMATCH).sort : Dir.glob('*').sort
dir_file = dir_file.reverse if options['r']

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

def long_format(dir_file)
  dir_file.each do |file_name|
    file_stat = File::Stat.new(file_name)

    hash_ftype = {"file" => "-", "directory" => "d", "characterSpecial" => "c", "blockSpecial" => "b", "fifo" => "p", "link" => "l", "socket" => "s"}
    ftype = file_stat.ftype
    file_type = hash_ftype[ftype]

    file_mode = file_stat.mode.to_s(8).slice(-3, 3).to_s.split('')
    mode_array = []
    file_mode.each do |f|
      hash_mode = {"7" => "rwx", "6" => "rw-", "5" => "r-x", "4" => "r--", "3" => "-wx", "2" => "-w-", "1" => "--x", "0" => "---"}
      mode_array << hash_mode[f]
    end
    permission = mode_array.join

    hard_link = file_stat.nlink.to_s.rjust(2, ' ')
    owner_name = Etc.getpwuid(file_stat.uid).name
    group_name = Etc.getgrgid(file_stat.gid).name
    byte_size = file_stat.size.to_s.rjust(5, ' ')
    time_stamp = file_stat.mtime.strftime("%_m %_d %R")
    print(file_type, permission, ' ', hard_link, ' ', owner_name, '  ', group_name, ' ', byte_size, ' ', time_stamp, ' ', file_name, "\n")
  end
end

if options['l']
  long_format(dir_file)
else
  multiple_columns(dir_file)
end
