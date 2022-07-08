

usdsc_token = USDSC[-1]
price_feed = PriceFeed[-1]
abhi = accounts[0]
abhi.transfer(usdsc_token.address, Wei(1e18))

price_feed.fetchPrice()/1e18

