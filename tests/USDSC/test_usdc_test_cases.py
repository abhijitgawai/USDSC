from brownie import Wei, reverts, accounts, chain

def test_swapUsdscToBnb(isolation, owner, USDSC, PriceFeed, MockV3Aggregator, MainPool, BUSD,  alice):
    usdsc_token = USDSC[-1]
    price_feed = PriceFeed[-1]
    main_pool = MainPool[-1]
    mockv3_aggregator = MockV3Aggregator[-1]
    

    # Checking Price of BNB
    assert 240 == price_feed.fetchPrice()/1e18

    requested_usdsc = 500e18

    expected_bnb_to_send = main_pool.swapBnbToUsdsc(requested_usdsc)

    alice.transfer(main_pool.address, expected_bnb_to_send)

    assert requested_usdsc/1e18 == usdsc_token.balanceOf(alice)/1e18 # Here is catch diving 1e18 removes little error


def test_usdsc(isolation, owner, USDSC, PriceFeed, MockV3Aggregator, MainPool, BUSD,  alice):
    usdsc_token = USDSC[-1]
    price_feed = PriceFeed[-1]
    main_pool = MainPool[-1]
    mockv3_aggregator = MockV3Aggregator[-1]
    

    # Checking Price of BNB
    assert 240 == price_feed.fetchPrice()/1e18

    requested_usdsc = 500e18

    expected_bnb_to_send = main_pool.swapBnbToUsdsc(requested_usdsc)

    alice.transfer(main_pool.address, expected_bnb_to_send)

    assert requested_usdsc/1e18 == usdsc_token.balanceOf(alice)/1e18 # Here is catch diving 1e18 removes little error

