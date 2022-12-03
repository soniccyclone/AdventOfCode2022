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


proc getPredestinedScore(opponent, outcome: string): int =
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

proc getTotalPredestinedScore(file: File): int =
    for line in file.lines:
        var plays = line.split(' ')
        result += getPredestinedScore(plays[0], plays[1])

proc dayTwo*(fileName: string) =
    echo "Day 2 Part 1: ", getTotalScore(open(fileName))
    echo "Day 2 Part 2: ", getTotalPredestinedScore(open(fileName))

when isMainModule:
    assert getTotalScore(open("src/day2/test.in")) == 15
    assert getTotalScore(open("src/day2/day2.in")) == 10816
    assert getTotalPredestinedScore(open("src/day2/test.in")) == 12
    assert getTotalPredestinedScore(open("src/day2/day2.in")) == 11657
    echo "All tests passed!"