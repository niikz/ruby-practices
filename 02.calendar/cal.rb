#!/usr/bin/env ruby

require 'optparse'
require 'date'

# コマンド入力から年月を指定
params = ARGV.getopts("y:", "m:")
today = Date.today
year = params["y"].to_i
month = params["m"].to_i
if params["y"].nil?
  year = today.year
elsif params["y"].to_i < 1 || params["y"].to_i > 9999
  puts "cal: year `#{year}' not in range 1..9999"
  return
end
if params["m"].nil?
  month = today.month
elsif params["m"].to_i < 1 || params["m"].to_i > 12
  puts "calcal: #{month} is neither a month number (1..12) nor a name"
  return
end
# カレンダーの装飾を追加
puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"
# 今月のカレンダーを表示
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
(first_date.mday..last_date.mday).each do |i|
  date = Date.new(year, month, i)
  day = date.strftime('%e')
  white_space = "   "
  day = (white_space * first_date.cwday) + day if i == 1
  if date.cwday % 6 == 0
    print(day, "\n")
  else
    print(day, " ")
  end
end
print("\n")
