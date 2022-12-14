import math, sets, sequtils, tables, sugar, strutils, system/iterators, ../testHelpers

const priority = collect:
  for index, letter in toSeq('a'..'z')
             .concat(toSeq('A'..'Z'))
             .pairs:
    (letter, index + 1)
const priorityLookup = priority.toTable

func getPrioritySum(file: string): int =
    file.split("\r\n")
    .map(rucksack => rucksack.toSeq
        .distribute(2)
        .map(compartment => compartment.toHashSet)
        .foldl(a * b)
        .map(item => priorityLookup[item])
        .toSeq.sum)
    .sum

func getBadgeSum(lines: seq[string]): int =
    lines
    .map(elf => elf.toHashSet)
    .distribute(lines.len.floorDiv(3))
    .map(groupElf => groupElf
        .foldl(a * b)
        .map(badge => priorityLookup[badge])
        .toSeq.sum)
    .sum

proc dayThree*(fileName: string) =
    echo "Day 3 Part 1: ", getPrioritySum(readFile(fileName))
    echo "Day 3 Part 2: ", getBadgeSum(readFile(fileName).split("\r\n"))

proc testDayThree*(testFilePath: string) =
    let test = readFile(testFilePath)
    assertExpected(157, getPrioritySum(test))
    assertExpected(70, getBadgeSum(test.split("\r\n")))

when isMainModule:
    testDayThree("src/input/day3.test")
    echo "All tests passed!"