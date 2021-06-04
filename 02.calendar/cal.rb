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
