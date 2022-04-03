#!/bin/bash
tar -cvz --exclude '.DS_Store' --exclude '.dropbox' --exclude '.dropbox.cache' --exclude 'Icon?' -f ./dropbox.tar.gz -C ~ Dropbox