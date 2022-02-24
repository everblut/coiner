class CryptoCoin < ApplicationRecord
  def self.instance
    find_or_create_by(singleton_lock: 1)
  end
end
