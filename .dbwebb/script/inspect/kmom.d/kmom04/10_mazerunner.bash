#!/usr/bin/env bash

function testMaze {
    read -r -p "Execute mazerunner $*? [Y/n] " response

    if [ ! "$response" = "n" ]
    then
        echo ""
        echo "#################"
        echo "Testing: $1"
        echo "#################"
        # shift
        echo ""
        bash mazerunner.bash "$@"
        echo ""
        sleep 1
    fi
}
echo "Starting server..."
cd "me/kmom04/maze" && node index.js &
sleep 2

# Test client.bash
cd "me/kmom04/maze" || exit 1

testMaze "init"
testMaze "maps"
testMaze "select" "1"
testMaze "enter"
testMaze "go" "east"
testMaze "go" "east"
testMaze "go" "south"
testMaze "go" "south"
testMaze "go" "south"
testMaze "go" "west"
testMaze "go" "west"
testMaze "LOOP" "loop"


read -r -p "Do you to view mazerunner.bash? [Y/n] " response

if [ ! "$response" = "n" ]
then
    cat mazerunner.bash
fi


# Kill server
echo ""
echo "Killing the server..."
if [ -f "pid" ]
then
    PID=$(< "pid")
fi

kill $PID
sleep 1
echo "Server dead :)"
