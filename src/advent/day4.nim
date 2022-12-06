import math, sets, sequtils, tables, sugar, strutils, system/iterators

func isAssignmentContained(elfGroup: string): bool =
    let elves = elfGroup.split(",")
    let elf1 = elves[0]
    let elf2 = elves[1]
    let elf1Bounds = elf1.split("-")
    let elf1Start = elf1Bounds[0]
    let elf1End = elf1Bounds[1]
    let elf2Bounds = elf2.split("-")
    let elf2Start = elf2Bounds[0]
    let elf2End = elf2Bounds[1]
    (elf1Start <= elf2Start and elf1End >= elf2End) or (elf2Start < elf1Start and elf2End > elf1End)

func sharedUniverses(line: seq[string]): int =
    line.map(isAssignmentContained).filterIt(it).len

proc dayFour*(fileName: string) =
    echo "Day 4 Part 1: ", sharedUniverses(readFile(fileName).split("\r\n"))

when isMainModule:
    assert sharedUniverses(readFile("src/input/day4.test").split("\r\n")) == 2
    echo "All tests passed!"