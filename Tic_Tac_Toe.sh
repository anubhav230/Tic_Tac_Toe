#!/bin/bash
declare -a board
count=0
boradPrint() {
	for place in {1..9}
	do
		board[((count++))]=$place
	done
	echo "${board[0]} | ${board[1]} | ${board[2]}"
	echo ---------
	echo "${board[3]} | ${board[4]} | ${board[5]}"
	echo ---------
	echo "${board[6]} | ${board[7]} | ${board[8]}"
}
boradPrint
