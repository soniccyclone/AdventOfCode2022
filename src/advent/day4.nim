import sequtils, strutils, system/iterators, std/strformat

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

    (elves[0].start <= elves[1].finish) and
    (elves[1].start <= elves[0].finish)

func assignmentsOverlapped(lines: seq[string]): int =
    lines.map(isOverlapped).filterIt(it).len

proc dayFour*(fileName: string) =
    echo "Day 4 Part 1: ", sharedUniverses(readFile(fileName).split("\r\n"))
    echo "Day 4 Part 2: ", assignmentsOverlapped(readFile(fileName).split("\r\n"))

when isMainModule:
    let part1 = sharedUniverses(readFile("src/input/day4.test").split("\r\n"))
    assert part1 == 2, &"Expected 2, got {part1}"
    let part2 = assignmentsOverlapped(readFile("src/input/day4.test").split("\r\n"))
    assert part2 == 4, &"Expected 4, got {part2}"
    echo "All tests passed!"