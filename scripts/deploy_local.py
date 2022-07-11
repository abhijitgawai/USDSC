from dis import Bytecode
from brownie import accounts, Wei, chain, network
from brownie import (USDSC, MockV3Aggregator, PriceFeed, BUSD, MainPool)
from pyrsistent import s
from scripts.utils.helpful_scripts import *
from web3 import HTTPProvider, Web3


owner = accounts[0]
my_address = accounts[0].address
chain_id = 80001
w3 = Web3(Web3.HTTPProvider(''))


def sign_deploy(contract, *args):
    transaction = contract.constructor(*args).buildTransaction(
    {
        "chainId": chain_id,
        "gasPrice": w3.eth.gas_price,
        "from": my_address,
        "nonce": w3.eth.getTransactionCount(my_address),
    })
    # Sign the transaction
    signed_txn = w3.eth.account.sign_transaction(transaction, private_key=private_key)
    tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)
    return tx_receipt.contractAddress
    

def set_addresses(contract, *args):
    transaction = contract.functions.setAddresses(*args).buildTransaction(
        {
        "chainId": chain_id,
        "gasPrice": w3.eth.gas_price,
        "from": my_address,
        "nonce": w3.eth.getTransactionCount(my_address),
    })
    # Sign the transaction
    signed_txn = w3.eth.account.sign_transaction(transaction, private_key=private_key)
    tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)


def set_params(contract, *args):
    transaction = contract.functions.setParams(*args).buildTransaction(
        {
        "chainId": chain_id,
        "gasPrice": w3.eth.gas_price,
        "from": my_address,
        "nonce": w3.eth.getTransactionCount(my_address),
    })
    # Sign the transaction
    signed_txn = w3.eth.account.sign_transaction(transaction, private_key=private_key)
    tx_hash = w3.eth.send_raw_transaction(signed_txn.rawTransaction)
    tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)


def deploy_eth():
    owner =  accounts[0]
    usdsc_token = USDSC.deploy({"from":owner})
    price_aggregator_address = MockV3Aggregator.deploy(18, 240e18, {"from":owner}) 
    # Change with address for BSC Mainnet- "0x0567f2323251f0aab15c8dfb1967e4e8a7d42aee" or BSC Testnet- "0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526"
    price_feed  = PriceFeed.deploy({"from":owner})
    price_feed.setAddress(price_aggregator_address, {"from":owner})
    # print(usdsc_token.address)
    main_pool = MainPool.deploy({"from":owner})
    busd  = BUSD.deploy(main_pool.address, {"from":owner})
    usdsc_token.Initialize(main_pool.address, {"from":owner})

    # Setting Address
    main_pool.setAddresses(price_feed.address, usdsc_token, busd.address, {"from":owner})

    


def main():
    # get_verified()
    deploy_eth()
