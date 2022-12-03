import std/strutils

proc isTie(opponent, you: string): bool =
    (opponent == "A" and you == "X") or
    (opponent == "B" and you == "Y") or
    (opponent == "C" and you == "Z")

proc isVictory(opponent, you: string): bool =
    (opponent == "C" and you == "X") or
    (opponent == "A" and you == "Y") or
    (opponent == "B" and you == "Z")

proc getScore(opponent, you: string): int =
    if isTie(opponent, you):
        result += 3
    elif isVictory(opponent, you):
        result += 6
    
    if you == "X":
        result += 1
    elif you == "Y":
        result += 2
    else:
        result += 3

proc getTotalScore(file: File): int =
    for line in file.lines:
        let plays = line.split(' ')
        result += getScore(plays[0], plays[1])

proc dayTwo*(fileName: string) =
    echo "Day 2 Part 1: ", getTotalScore(open(fileName))

when isMainModule:
    block:
        let data = open("src/day2/test.in")
        assert getTotalScore(data) == 15
        echo "All tests passed!"