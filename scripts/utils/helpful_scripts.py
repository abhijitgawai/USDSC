from brownie import (
    accounts, 
    network, 
    config,
    Wei
)

LOCAL_BLOCKCHAIN_NETWORKS = ["development", "ganache-local"]

def get_accounts(num=1):
    if network.show_active() in LOCAL_BLOCKCHAIN_NETWORKS:
        return accounts[:num]
    else:
        return accounts.add(config['wallet']['from_key'])


