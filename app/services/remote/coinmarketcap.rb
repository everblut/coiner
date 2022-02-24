class Remote::Coinmarketcap
  include HTTParty
  base_uri ENV.fetch('COINMARKETCAP_API_BASE_URL') { 'https://pro-api.coinmarketcap.com' }

  def self.coins
    value = {}
    begin
      response = get('/v1/cryptocurrency/quotes/latest', self.hard_options)
      value = response.parsed_response
    rescue => error
      Rails.logger.error("Error on json marketcap response #{error}")
    end
    value
  end

  private

  def self.hard_options
    { query: default_query, headers: default_headers }
  end

  def self.default_query
    { slug: 'bitcoin,ethereum' }
  end

  def self.default_headers
    {
      'X-CMC_PRO_API_KEY': ENV.fetch('COINMARKETCAP_API_KEY') { 'KEY' },
      'Accept': 'application/json',
      'Accept-Encoding': 'deflate,gzip'
    }
  end
end