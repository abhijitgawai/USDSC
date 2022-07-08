import pytest
from brownie import accounts, Wei, chain
from brownie import (USDSC, MockV3Aggregator, PriceFeed)
from scripts.utils.helpful_scripts import *


@pytest.fixture(scope="module", autouse="True")
def shared_setup(module_isolation):
    pass

@pytest.fixture(scope="module")
def owner():
    return accounts[0]

@pytest.fixture(scope="module")
def alice():
    return accounts[1]

@pytest.fixture(scope="module")
def bob():
    return accounts[2]

@pytest.fixture(scope="module")
def charlie():
    return accounts[3]

@pytest.fixture(scope="module")
def katy():
    return accounts[4]

@pytest.fixture(scope="module")
def lauren():
    return accounts[5]

@pytest.fixture(scope="module")
def extWallet():
    return accounts[6]

@pytest.fixture(scope="module")
def treasuryWalllet():
    return accounts[7]

@pytest.fixture(scope="module")
def users():
    return accounts[8:]

@pytest.fixture(scope="module", autouse=True)
def deploy(owner, alice, bob, katy, lauren, charlie):
    owner =  accounts[0]
    usdsc_token = USDSC.deploy({"from":owner})
    price_aggregator_address = MockV3Aggregator.deploy(18, 240e18, {"from":owner}) 
    # Change with address for BSC Mainnet- "0x0567f2323251f0aab15c8dfb1967e4e8a7d42aee" or BSC Testnet- "0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526"
    price_feed  = PriceFeed.deploy({"from":owner})
    price_feed.setAddress(price_aggregator_address, {"from":owner})
    # print(usdsc_token.address)

    # Setting Address
    usdsc_token.setAddresses(price_feed.address, {"from":owner})