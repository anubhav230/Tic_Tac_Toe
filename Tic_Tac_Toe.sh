
#!/bin/bash

flag=1
declare -a board
player=1
system=0
count=0
#Printing Board
boardPrint() {
	echo "${board[0]} | ${board[1]} | ${board[2]}"
	echo "-------"
	echo "${board[3]} | ${board[4]} | ${board[5]}"
	echo "-------"
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

echo "system symbol = $systemSymbol"
echo "player symbol = $playerSymbol"
#checking winning condition
winnigCheck() {
		symbol=$1
		winner=$2
		if [[ ${board[0]} == $symbol && ${board[1]} == $symbol && ${board[2]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			exit
		elif [[ ${board[3]} == $symbol && ${board[4]} == $symbol && ${board[5]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			exit
		elif [[ ${board[6]} == $symbol && ${board[7]} == $symbol && ${board[8]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			exit
		elif [[ ${board[0]} == $symbol && ${board[3]} == $symbol && ${board[6]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			exit
		elif [[ ${board[1]} == $symbol && ${board[4]} == $symbol && ${board[7]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			exit
		elif [[ ${board[2]} == $symbol && ${board[5]} == $symbol && ${board[8]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			exit
		elif [[ ${board[0]} == $symbol && ${board[4]} == $symbol && ${board[8]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			exit
		elif [[ ${board[2]} == $symbol && ${board[4]} == $symbol && ${board[6]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			exit
		fi
}
#checking tie condition
matchTie() {
	for (( count = 0; count <= 8; count++ ))
	do
		if [ -z "${board[count]}" ]
		then
			echo "match not tie"
			break
		elif (( $count == 8 ))
		then
			echo "========= Match tie========"
			exit
		fi
	done
}

#player playing game
playerPlay() {
	echo "=========== player chance =========="
	win="player"
	boardPrint
        read -p "please enter position where you want to put symbol: " playerPosition
	if [ -z "${board[$playerPosition]}" ]
	then
		if (( $playerPosition >= 0 && $playerPosition <= 8 ))
		then
              		board[$playerPosition]=$playerSymbol
			#symbol=$playerSymbol
                	boardPrint
                	winnigCheck $playerSymbol $win
			matchTie
		else
			echo "envalid input place already taken"
	    		playerPlay
		fi
	else

		echo "envalid input place already taken"
		playerPlay
	fi
}

#system playing game
systemRandomPlay() {
	echo "============= system chance =============="
	win2="System"
        systemPosition=$((RANDOM%8))
	if [ -z "${board[$systemPosition]}" ]
	then
        	board[$systemPosition]=$systemSymbol
        	boardPrint
        	winnigCheck $systemSymbol $win2
		matchTie
	else
		systemRandomPlay
	fi
	echo "============= system played =============="
}



systemPlay() {
	echo "Syatem Play"
}



#game started
gameStart() {
	if [ $toss -eq $player ]
	then
		while [ $flag -eq 1 ]
		do
			playerPlay
			systemRandomPlay
		done
	else
		while [ $flag -eq 1  ]
		do
			systemRandomPlay
			playerPlay
		done
	fi
}

echo "=========Main========"
#toss function calling
firstToss
#symbolAssigining function calling
symbolAssigning
#gameStart function calling
gameStart







