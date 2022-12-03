import math, sets, sequtils, tables, sugar, strutils

func getRucksackTotal(rucksack: string): int =
    let compartmentOne = toHashSet(rucksack[0..<rucksack.len.floorDiv(2)])
    let compartmentTwo = toHashSet(rucksack[rucksack.len.floorDiv(2)..^1])
    let sharedItems = compartmentOne * compartmentTwo
    # let alphabet = toSeq('a'..'z').concat(toSeq('A'..'Z')).enumerate.toTable
    # would be far superior to the next two lines but enumerate requires it be
    # used within a for loop...would also need to mess with indexes more that
    # way too I guess ¯\_(ツ)_/¯
    let priority = toSeq('a'..'z').concat(toSeq('A'..'Z'))
    let priorityLookup = zip(priority, toSeq(1..priority.len)).toTable
    sharedItems.map((item) => priorityLookup[item]).toSeq.sum

func getPrioritySum(file: string): int =
        file.split("\r\n")
        .map((rucksack) => getRucksackTotal(rucksack))
        .sum

proc dayThree*(fileName: string) =
    echo "Day 3 Part 1: ", getPrioritySum(readFile(fileName))

when isMainModule:
    assert getPrioritySum(readFile("src/day3/test.in")) == 157
    echo "All tests passed!"