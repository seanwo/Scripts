#! /bin/sh

find "$1" \( \
	-name '._*' \
	-or -name '*DS_Store' \
	-or -name '.fseventsd' \
	-or -name '.Trashes' \
	-or -name '.TemporaryItems' \
	-or -name '.Spotlight-V100' \
	-or -name '.DocumentRevisions-V100' \) \
	-delete 
