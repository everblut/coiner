class CreateCryptoCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :crypto_coins, id: false do |t|
      t.primary_key :singleton_lock
      t.datetime :last_sync_at
      t.decimal :eth_price, precision: 10, scale: 11, default: 0.0
      t.decimal :btc_price, precision: 10, scale: 11, default: 0.0
      t.timestamps
    end
    CryptoCoin.instance
  end
end
