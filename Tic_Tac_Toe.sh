#!/bin/bash
declare -a board
player=1
system=0
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
toss=$((RANDOM%2))
if [ $toss -eq $player ]
then
	echo "Player won the toss and have chance to play first"
else
	echo "System won the toss and have chence to play first"
fi
