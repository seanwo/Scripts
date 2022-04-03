#!/bin/bash
tar -cvz --exclude '.DS_Store' -f ./documents.tar.gz -C ~ Documents/applications Documents/filecabinet Documents/firmwares Documents/openvpn
