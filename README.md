# Coiner

Focus points:

* Ruby and gems administration with rvm
* Database **Sqlite3**
* Only one route, only one controller
* One ActiveRecord Model (**CryptoCoin**), One PORO (**InvestmentCalculation**)
* Singleton emulation on **CryptoCoin** for eth and btc price persistance.
* Added a **app/services** for API request and investment calculation processing.
* CoinMarketCap API usage
* SyncCoinPriceService for remote and local syncing, prevents more than one request per-minute to the remote server.
* InvestmentCalculationService for monthly calculations using ruby
* HomeController with html and js view rendering
* Added only 2 gems to the raw project:
  * Figaro for environment administration
  * Httparty as a client for the API requests

Missing:

* No testing
* CSV/JSON download ( serialization or send_data with mime-type would have done the trick )
* Show on realtime coin prices ( ajax polling, wss doesn't fit )
