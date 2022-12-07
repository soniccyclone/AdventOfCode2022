import sequtils, strutils, system/iterators

func elfBounds(elf: string): tuple[start, finish: int] =
    let bounds = elf.split("-").map(parseInt)
    (bounds[0], bounds[1])

func isAssignmentContained(elfGroup: string): bool =
    let elves = elfGroup.split(",").map(elfBounds)

    (elves[0].start <= elves[1].start and elves[0].finish >= elves[1].finish) or
    (elves[1].start <= elves[0].start and elves[1].finish >= elves[0].finish)

func sharedUniverses(line: seq[string]): int =
    line.map(isAssignmentContained).filterIt(it).len

proc dayFour*(fileName: string) =
    echo "Day 4 Part 1: ", sharedUniverses(readFile(fileName).split("\r\n"))

when isMainModule:
    assert sharedUniverses(readFile("src/input/day4.test").split("\r\n")) == 2
    echo "All tests passed!"