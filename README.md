usdsc_token = USDSC[-1]
price_feed = PriceFeed[-1]
busd = BUSD[-1]
main_pool = MainPool[-1]
abhi = accounts[0]

abhi.transfer(main_pool.address, Wei(1e18))
usdsc_token.balanceOf(abhi)/1e18

price_feed.fetchPrice()/1e18
usdsc_token.bnbusdscFee()/1e18

main_pool.swapBnbToUsdsc(500e18)

 == (500 * 1.01)/240

main_pool.setBnbUsdscFee(2e18, {"from":abhi})