class InvestTotalSimuration
  attr_accessor :fund, :increase_price, :invest_period, :return_percentage

  def initialize(fund, increase_price, invest_period, return_percentage)
    @fund = fund
    @increase_price = increase_price
    @invest_period = invest_period
    @return_percentage = return_percentage /= 100
  end
  
  def capital_increase
    @fund += @increase_price
  end

  def return_included_fund
    @fund *= 1 + @return_percentage
  end

  def gain_simulation
    @invest_period.times do |year_count|
      if year_count == 0
        return_included_fund()
        puts "1年目の成績：#{@fund}円"
      else
        capital_increase()
        return_included_fund()
        puts "#{year_count + 1}年目の成績：#{@fund}円"
      end
    end
  end
end

def format_for_price(price)
  format_for_price = []
  price.to_s.reverse.split('').each.with_index(1) do |element, index|
    format_for_price.unshift(element)
    if index % 3 == 0 && price.to_s.length != index
      format_for_price.unshift(',')
    end
  end
  format_for_price.join
end

# puts '目的を(1)(2)から選んでください。'
# puts '回答：'
# (1)投資金額から、
# (2)目標金額から逆算できるようにする

puts '原資はいくらですか？'
fund = gets.to_i
fund_formatted = format_for_price(fund)

puts '1年間あたりの増資額はいくらですか？'
increase_price = gets.to_i
increase_price_formatted = format_for_price(increase_price)

puts '何年で計算しますか？'
invest_period = gets.to_i

puts '想定リターンは何パーセントですか？（整数で入力してください ex.10.0, 20.0..etc）'
return_percentage = gets.to_f

puts '-' * 30
puts "原資：#{fund_formatted}円\n一年間あたりの増資額：#{increase_price_formatted}円\n投資期間：#{invest_period}年\n想定利回り：#{return_percentage}%\n"
puts '-' * 30
puts "として計算します。"

puts '何かキーを押してください。';gets

invest = InvestTotalSimuration.new(fund, increase_price, invest_period, return_percentage)

total_gain = invest.gain_simulation()

# 目標金額から逆算できるようにする