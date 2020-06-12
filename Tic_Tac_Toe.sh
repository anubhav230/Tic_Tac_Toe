#!/bin/bash

flag=1
declare -a board
#EMPTY=''
player=1
system=0
count=0

#Printing Board
boardPrint() {
	echo "                                                      "
	echo "              ${board[1]} | ${board[2]} | ${board[3]} "
	echo "              --------"
	echo "              ${board[4]} | ${board[5]} | ${board[6]} "
	echo "              --------"
	echo "              ${board[7]} | ${board[8]} | ${board[9]} "
	echo "                                                      "
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

#checking winning condition
winnigCheck() {
		symbol=$1
		winner=$2
		if [[ ${board[1]} == $symbol && ${board[2]} == $symbol && ${board[3]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			boardPrint
			exit
		elif [[ ${board[4]} == $symbol && ${board[5]} == $symbol && ${board[6]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			boardPrint
			exit
		elif [[ ${board[7]} == $symbol && ${board[8]} == $symbol && ${board[9]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			boardPrint
			exit
		elif [[ ${board[1]} == $symbol && ${board[4]} == $symbol && ${board[7]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			boardPrint
			exit
		elif [[ ${board[2]} == $symbol && ${board[5]} == $symbol && ${board[8]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			boardPrint
			exit
		elif [[ ${board[3]} == $symbol && ${board[6]} == $symbol && ${board[9]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			boardPrint
			exit
		elif [[ ${board[1]} == $symbol && ${board[5]} == $symbol && ${board[9]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			boardPrint
			exit
		elif [[ ${board[3]} == $symbol && ${board[5]} == $symbol && ${board[7]} == $symbol ]]
		then
			echo "==================$winner is winner================="
			boardPrint
			exit
		fi
}



#checking tie condition
matchTie() {
	for (( count=1;count<10;count++ ))
	do
		if [ -z "${board[count]}" ]
		then
			echo "match not tie"
			break
		else
			if (( $count == 9 ))
			then
				boardPrint
				echo "=================[[ Match tie ]]==============="
				exit
			fi
		fi
	done
}

#//player playing game
playerPlay() {
	echo "=========== player chance =========="
	win="player"
	boardPrint
        read -p "please enter position where you want to put symbol: " playerPosition
	if [ -z "${board[$playerPosition]}" ]
	then
		if (( $playerPosition >= 1 && $playerPosition <= 9 ))
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

#//system playing game with help of RANDOM fuction so if system will not have any cell to planed positiion
systemRandomPlay() {
	echo "============= system chance =============="
	win2="System"
        systemPosition=$((RANDOM%9+1))
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

#//System playe like a human by checking opponent places
systemPlay() {
	for (( cellNumber=1;cellNumber<10;cellNumber++ ))
	do
		if [ -z "${board[$cellNumber]}" ]
		then
			board[$cellNumber]="$systemSymbol"
			echo "system win check"
			player="system"
			winnigCheck $systemSymbol $player
			matchTie
			board[$cellNumber]=""

		fi
	done
	opponentBlocking

}
#//function for blacking opponent place where he can win the game
opponentBlocking() {
	flag2=1
	echo "==================================opponent Blocking=================================="
	for (( cellBlock=1;cellBlock<10;cellBlock++ ))
	do
		if [ -z "${board[$cellBlock]}" ]
		then
			board[$cellBlock]="$playerSymbol"
			echo "checking for player winning condition if nay then blocking"
			winningCheckForOpp "$playerSymbol"
			board[$cellBlock]=""

		fi
	done
	if [ $flag2 -eq 1 ]
	then
		cornerApproach
	fi
}

#//function for Corner Approach for System
cornerApproach() {
	echo "==========corner blocking========="
	if [ -z "${board[1]}" ]
	then
		board[1]="$systemSymbol"
	elif [ -z "${board[3]}" ]
	then
		board[3]="$systemSymbol"
	elif [ -z "${board[7]}" ]
        then
                board[7]="$systemSymbol"
	elif [ -z "${board[9]}" ]
        then
                board[9]="$systemSymbol"
	else
		echo "===============Did not find any corner to block==========="
		centreApproach
	fi


}

#//function for Centre approach for system

centreApproach() {
	echo "==========centre blocking==========="
	if [ -z "${board[5]}" ]
	then
		board[5]="$systemSymbol"
	else
		echo "=============There is no centre to blaock==checking Randomly==============="
		systemRandomPlay
	fi

}

#//fuction to analysing player winning cells for blocking
winningCheckForOpp() {

        symbol2=$1
        if [[ ${board[1]} == $symbol2 && ${board[2]} == $symbol2 && ${board[3]} == $symbol2 ]]
        then
                board[$cellBlock]="$systemSymbol"
		flag2=2
		cellBlock=10
	elif [[ ${board[4]} == $symbol2 && ${board[5]} == $symbol2 && ${board[6]} == $symbol2 ]]
        then
                board[$cellBlock]="$systemSymbol"
		flag2=2
                cellBlock=10
	elif [[ ${board[7]} == $symbol2 && ${board[8]} == $symbol2 && ${board[9]} == $symbol2 ]]
        then
                board[$cellBlock]="$systemSymbol"
		flag2=2
                cellBlock=10
	elif [[ ${board[1]} == $symbol2 && ${board[4]} == $symbol2 && ${board[7]} == $symbol2 ]]
        then
                board[$cellBlock]="$systemSymbol"
		flag2=2
                cellBlock=10
	elif [[ ${board[2]} == $symbol2 && ${board[5]} == $symbol2 && ${board[8]} == $symbol2 ]]
        then
                board[$cellBlock]="$systemSymbol"
		flag2=2
                cellBlock=10
	elif [[ ${board[3]} == $symbol2 && ${board[6]} == $symbol2 && ${board[9]} == $symbol2 ]]
        then
                board[$cellBlock]="$systemSymbol"
		flag2=2
                cellBlock=10
	elif [[ ${board[1]} == $symbol2 && ${board[5]} == $symbol2 && ${board[9]} == $symbol2 ]]
        then
                board[$cellBlock]="$systemSymbol"
		flag2=2
                cellBlock=10
	elif [[ ${board[3]} == $symbol2 && ${board[5]} == $symbol2 && ${board[7]} == $symbol2 ]]
        then
                board[$cellBlock]="$systemSymbol"
		flag2=2
                cellBlock=10
	fi
}




#game started
gameStart() {
	if [ $toss -eq $player ]
	then
		while [ $flag -eq 1 ]
		do
			playerPlay
			systemPlay
		done
	else
		while [ $flag -eq 1  ]
		do
			systemPlay
			playerPlay
		done
	fi
}

echo "=========Main========"
#toss function calling
firstToss
#symbolAssigining function calling
symbolAssigning

echo "system symbol = $systemSymbol"
echo "player symbol = $playerSymbol"


#gameStart function calling
gameStart







