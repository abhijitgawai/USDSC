from brownie import Wei, reverts, accounts, chain

def test_usdsc(isolation, owner, USDSC, PriceFeed, MockV3Aggregator, alice):
    usdsc_token = USDSC[-1]
    price_feed = PriceFeed[-1]
    mockv3_aggregator = MockV3Aggregator[-1]
    

    # Checking Price of BNB
    assert 240 == price_feed.fetchPrice()/1e18

    alice.transfer(usdsc_token.address, Wei(1e18))

    assert 240 == usdsc_token.balanceOf(alice)/1e18

    assert 240 == usdsc_token.totalSupply()/1e18

