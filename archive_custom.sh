#!/bin/bash
tar -cvz --exclude '.DS_Store' -f ./custom.tar.gz -C ~ .profile .bash_profile local/bin
