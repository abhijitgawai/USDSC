from brownie import Wei, reverts, accounts, chain

def test_usdsc(isolation, owner, USDSC, PriceFeed, MockV3Aggregator, alice):
    usdsc_token = USDSC[-1]
    price_feed = PriceFeed[-1]
    mockv3_aggregator = MockV3Aggregator[-1]
    

    # Checking Price of BNB
    assert 240 == price_feed.fetchPrice()/1e18

    requested_usdsc = 500e18

    expected_bnb_to_send = usdsc_token.swapBnbToUsdsc(requested_usdsc)

    alice.transfer(usdsc_token.address, expected_bnb_to_send)

    assert requested_usdsc/1e18 == usdsc_token.totalSupply()/1e18

