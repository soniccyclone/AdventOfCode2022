import sequtils, strutils, system/iterators, ../testHelpers

func elfBounds(elf: string): tuple[start, finish: int] =
    let bounds = elf.split("-").map(parseInt)
    (bounds[0], bounds[1])

func isAssignmentContained(elfGroup: string): bool =
    let elves = elfGroup.split(",").map(elfBounds)

    (elves[0].start <= elves[1].start and elves[0].finish >= elves[1].finish) or
    (elves[1].start <= elves[0].start and elves[1].finish >= elves[0].finish)

func sharedUniverses(lines: seq[string]): int =
    lines.map(isAssignmentContained).filterIt(it).len

func isOverlapped(elfGroup: string): bool =
    let elves = elfGroup.split(",").map(elfBounds)

    elves[0].start <= elves[1].finish and
    elves[1].start <= elves[0].finish

func assignmentsOverlapped(lines: seq[string]): int =
    lines.map(isOverlapped).filterIt(it).len

proc dayFour*(fileName: string) =
    echo "Day 4 Part 1: ", sharedUniverses(readFile(fileName).split("\r\n"))
    echo "Day 4 Part 2: ", assignmentsOverlapped(readFile(fileName).split("\r\n"))

proc testDayFour*(testFilePath: string) =
    let test = readFile(testFilePath).split("\r\n")
    assertExpected(2, sharedUniverses(test))
    assertExpected(4, assignmentsOverlapped(test))

when isMainModule:
    testDayFour("src/input/day4.test")
    echo "All tests passed!"