#!/usr/bin/env ruby

require 'date'

# 今月のカレンダーを表示
year = 2021
month = 5
first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)
(first_date.mday..last_date.mday).each do |i|
  date = Date.new(year, month, i)
  day = date.strftime('%e')
  if date.cwday % 6 == 0
    print(day, "\n")
  else
    print(day, " ")
  end
end
print("\n")
