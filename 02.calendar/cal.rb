#!/usr/bin/env ruby

require 'date'

year = 2021
month = 5
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
# カレンダーの装飾を追加
str = "#{month}月 #{year}"
puts str.center(20)
puts "日 月 火 水 木 金 土"
# 今月のカレンダーを表示
(first_date.mday..last_date.mday).each do |i|
  date = Date.new(year, month, i)
  day = date.strftime('%e')
  white_space = "   "
  if i == 1
    day_of_the_week = first_date.cwday
    case day_of_the_week
    when 1
      day = white_space + day
    when 2
      day = white_space * 2 + day
    when 3
      day = white_space * 3 + day
    when 4
      day = white_space * 4 + day
    when 5
      day = white_space * 5 + day
    when 6
      day = white_space * 6 + day
    end
  end
  if date.cwday % 6 == 0
    print(day, "\n")
  else
    print(day, " ")
  end
end
print("\n")
