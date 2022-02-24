class InvestmentCalculationService

  def self.call(coin_data, initial_investment)
    coins_price = coin_data.as_json(only: [:btc_price, :eth_price])
    investment = InvestmentCalculation.new(coins_price, initial_investment)
    investment.yearly_projection = self.calculate_year_projection(investment)
    investment
  end

  private

  def self.calculate_year_projection(investment_object)
    initial_investment = investment_object.initial_investment.to_f
    btc_unit = 1.0 / investment_object.btc_price.to_f rescue 0.0
    eth_unit = 1.0 / investment_object.eth_price.to_f rescue 0.0
    btc_earnings = (btc_unit * initial_investment) * investment_object.btc_monthly_rate
    eth_earnings = (eth_unit * initial_investment) * investment_object.eth_monthly_rate
    base_projection = {btc_earnings: btc_earnings, eth_earnings: eth_earnings}
    (1..11).reduce([base_projection]) do |months_projection, index|
      previous_month = months_projection[index - 1]
      btc = previous_month[:btc_earnings] * investment_object.btc_monthly_rate
      eth = previous_month[:eth_earnings] * investment_object.eth_monthly_rate
      months_projection << {btc_earnings: btc, eth_earnings: eth}
    end
  end

end