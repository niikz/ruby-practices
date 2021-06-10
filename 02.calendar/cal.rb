#!/usr/bin/env ruby

require 'optparse'
require 'date'

# コマンド入力から年月を指定
params = ARGV.getopts("y:", "m:")
year = (params["y"] || Date.today.year).to_i
month = (params["m"] || Date.today.month).to_i
if year < 1 || year > 9999
  puts "cal: year `#{year}' not in range 1..9999"
  return
end
if month < 1 || month > 12
  puts "calcal: #{month} is neither a month number (1..12) nor a name"
  return
end
# カレンダーの装飾を追加
puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"
# カレンダーを表示
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
(first_date..last_date).each do |date|
  day = date.strftime('%e')
  white_space = "   "
  day = (white_space * first_date.cwday) + day if date.mday == 1
  if date.saturday?
    print(day, "\n")
  else
    print(day, " ")
  end
end
print("\n")
