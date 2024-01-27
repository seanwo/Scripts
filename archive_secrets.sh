#!/bin/bash
gpg -a --export AC19DF4D259ED59DAE42983A7A79348C84D4D0BD > ~/.ssh/pgp.key.public
gpg -a --export-secret-keys AC19DF4D259ED59DAE42983A7A79348C84D4D0BD > ~/.ssh/pgp.key.private
tar -cvz --exclude '.DS_Store' -f ./secrets.tar.gz -C ~ .aws .ssh 
