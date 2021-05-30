#!/usr/bin/env ruby

require 'optparse'
require 'date'

# コマンド入力から年月を指定
params = ARGV.getopts("y:", "m:")
today = Date.today
year = params["y"]
month = params["m"]
if year == nil
  year = today.year
elsif year.to_i < 1 || year.to_i > 9999
  puts "cal: year `#{year}' not in range 1..9999"
  return
else
  year = year.to_i
end
if month == nil
  month = today.month
elsif month.to_i < 1 || month.to_i > 12
  puts "calcal: #{month} is neither a month number (1..12) nor a name"
  return
else
  month = month.to_i
end
# カレンダーの装飾を追加
str = "#{month}月 #{year}"
puts str.center(20)
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
