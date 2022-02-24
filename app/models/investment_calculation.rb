class InvestmentCalculation
  attr_reader :eth_price, :btc_price, :eth_monthly_rate, :btc_monthly_rate,
    :initial_investment
  attr_accessor :yearly_projection

  def initialize(coin_data, initial_investment)
    @eth_price = coin_data['eth_price']&.to_f || 0.0
    @btc_price = coin_data['btc_price']&.to_f || 0.0
    @btc_monthly_rate = 1.05
    @eth_monthly_rate = 1.03
    @initial_investment = (initial_investment || 0.0)
  end

  def monthly_projection
    @yearly_projection.each_with_index do |month, index|
      month[:eth_usd_earnings] = month[:eth_earnings] * @eth_price rescue 0.0
      month[:btc_usd_earnings] = month[:btc_earnings] * @btc_price rescue 0.0
      yield month, index+1
    end
  end
end