class SyncCoinPriceService

  def self.call(coin_data)
    last_sync_at = coin_data.last_sync_at || DateTime.now - 2.minutes
    self.process_coinmarket(coin_data) if should_call_remote?(last_sync_at)
  end

  private

  def self.should_call_remote?(last_sync_at)
    DateTime.now > (last_sync_at + 1.minute)
  end

  def self.process_coinmarket(coin_data)
    updated_price = extract_remote_prices
    coin_data.eth_price = updated_price.eth_price if updated_price.eth_price
    coin_data.btc_price = updated_price.btc_price if updated_price.btc_price
    coin_data.save
  end

  def self.extract_remote_prices
    response = Remote::Coinmarketcap.coins
    btc_price = scrap_btc_price(response)
    eth_price = scrap_eth_price(response)
    OpenStruct.new(btc_price: btc_price, eth_price: eth_price)
  end

  def self.scrap_btc_price(json)
    json&.dig('data','1','quote','USD','price')
  end

  def self.scrap_eth_price(json)
    json&.dig('data','1027','quote','USD','price')
  end
end
