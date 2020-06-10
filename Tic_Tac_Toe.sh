s#!/bin/bash

flage=1
declare -a board
player=1
system=0
count=0
#Printing Board
boardPrint() {
	#for place in {1..9}
	#do
		#board[((count++))]=
	#done
	echo "${board[0]} | ${board[1]} | ${board[2]}"
	echo ---------
	echo "${board[3]} | ${board[4]} | ${board[5]}"
	echo ---------
	echo "${board[6]} | ${board[7]} | ${board[8]}"
}
#Toss for first play
firstToss() {
	toss=$((RANDOM%2))
	if [ $toss -eq $player ]
	then
		echo "Player won the toss and have chance to play first"
	else
		echo "System won the toss and have chence to play first"
	fi
}
#assiginig symbol for player and system
symbolAssigning() {
	if [ $toss -eq $player ]
	then
		read -p "Please select symbol (x / o) for playing game: " playerSymbol
		if [ "$playerSymbol" == "o" ]
		then
			systemSymbol="x"
		else
			systemSymbol="o"
		fi
	else
		systemSymbolToss=$((RANDOM%2))
		if [ $systemSymbolToss -eq 1 ]
		then
			systemSymbol="o"
			playerSymbol="x"
		else
			systemSymbol="x"
			playerSymbol="o"
		fi
	fi
}
#boardPrint
firstToss
symbolAssigning

echo "system symbol = $systemSymbol"
echo "player symbol = $playerSymbol"

while (( flage >= 1 ))
do
	if [ $toss -eq $player ]
	then
		boardPrint
		read -p "please enter position where you want to put symbol: " playerPosition
		board[$playerPosition]=$playerSymbol
		boardPrint
	else
		systemPosition=$((RANDOM%9+1))
		board[$systemPosition]=$systemSymbol
		boardPrint
	fi
	flage=0
done




















