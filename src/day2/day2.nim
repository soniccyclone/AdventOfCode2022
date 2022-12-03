import std/strutils, sugar

func isTie(opponent, you: string): bool =
    (opponent == "A" and you == "X") or
    (opponent == "B" and you == "Y") or
    (opponent == "C" and you == "Z")

func isVictory(opponent, you: string): bool =
    (opponent == "C" and you == "X") or
    (opponent == "A" and you == "Y") or
    (opponent == "B" and you == "Z")

func getScore(opponent, you: string): int =
    if isTie(opponent, you):
        result += 3
    elif isVictory(opponent, you):
        result += 6
    
    case you:
    of "X":
        result += 1
    of "Y":
        result += 2
    of "Z":
        result += 3

func getPredestinedScore(opponent, outcome: string): int =
    case outcome:
    of "X":
        #loss
        case opponent:
        of "A":
            result += 3
        of "B":
            result += 1
        of "C":
            result += 2
    of "Y":
        #draw
        result += 3
        case opponent:
        of "A":
            result += 1
        of "B":
            result += 2
        of "C":
            result += 3
    of "Z":
        #win
        result += 6
        case opponent:
        of "A":
            result += 2
        of "B":
            result += 3
        of "C":
            result += 1

proc getTotal(file: File, scorer: (string, string) -> int): int =
    for line in file.lines:
        let plays = line.split(' ')
        result += scorer(plays[0], plays[1])

proc dayTwo*(fileName: string) =
    echo "Day 2 Part 1: ", getTotal(open(fileName), getScore)
    echo "Day 2 Part 2: ", getTotal(open(fileName), getPredestinedScore)

when isMainModule:
    assert getTotal(open("src/day2/test.in"), getScore) == 15
    assert getTotal(open("src/day2/day2.in"), getScore) == 10816
    assert getTotal(open("src/day2/test.in"), getPredestinedScore) == 12
    assert getTotal(open("src/day2/day2.in"), getPredestinedScore) == 11657
    echo "All tests passed!"