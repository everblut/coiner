class HomeController < ApplicationController
  around_action :sync_coin_price

  def index
    coin_data = CryptoCoin.instance
    @investment = InvestmentCalculationService.call(coin_data, initial_investment)
  end

  def show
    @coin_data = CryptoCoin.instance
  end

  private

  def initial_investment
    params.dig(:calculation, :initial_investment) || 0.0
  end

  def sync_coin_price
    yield
    SyncCoinPriceService.call(CryptoCoin.instance)
  end
end
