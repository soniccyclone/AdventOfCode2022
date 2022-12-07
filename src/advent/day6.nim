import strutils, std/sets, system/iterators, ../testHelpers

func getStartMarker(stream: string, distinctLetters: int): int =
    for i in distinctLetters..<stream.len:
        if stream[i-distinctLetters..i].toHashSet.len == distinctLetters + 1:
            return i + 1

func partOne(stream: string): int =
    getStartMarker(stream, 3)

func partTwo(stream: string): int =
    getStartMarker(stream, 13)

proc testDaySix*(testFilePath: string) =
    let tests = readFile(testFilePath).split("\r\n")
    for test in tests:
        let testCase = test.split(" ")
        assertExpected(testCase[1].parseInt, partOne(testCase[0]))
        assertExpected(testCase[2].parseInt, partTwo(testCase[0]))

proc daySix*(filePath: string) =
    echo "Day 6 Part 1: ", partOne(readFile(filePath))
    echo "Day 6 Part 2: ", partTwo(readFile(filePath))