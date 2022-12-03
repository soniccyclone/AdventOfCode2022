import math, sets, sequtils, tables, sugar, strutils

# const alphabet = toSeq('a'..'z').concat(toSeq('A'..'Z')).enumerate.toTable
# would be far superior to the next two lines but enumerate requires it be
# used within a for loop...would also need to mess with indexes more with 
# that single line solution too I guess ¯\_(ツ)_/¯
const priority = toSeq('a'..'z').concat(toSeq('A'..'Z'))
const priorityLookup = zip(priority, toSeq(1..priority.len)).toTable

func getRucksackTotal(rucksack: string): int =
    rucksack.toSeq.distribute(2)
    .map(compartment => compartment.toHashSet)
    .foldl(a * b)
    .map((item) => priorityLookup[item])
    .toSeq
    .sum

func getPrioritySum(file: string): int =
    file.split("\r\n")
    .map((rucksack) => getRucksackTotal(rucksack))
    .sum

func getBadgeSum(lines: seq[string]): int =
    lines.distribute(lines.len.floorDiv(3))
    .map(elfGroup => priorityLookup[
            (toHashSet(elfGroup[0]) * toHashSet(elfGroup[1]) * toHashSet(elfGroup[2])).toSeq[0]
        ])
    .sum

proc dayThree*(fileName: string) =
    echo "Day 3 Part 1: ", getPrioritySum(readFile(fileName))
    echo "Day 3 Part 2: ", getBadgeSum(readFile(fileName).split("\r\n"))

when isMainModule:
    assert getPrioritySum(readFile("src/input/day3.test")) == 157
    assert getBadgeSum(readFile("src/input/day3.test").split("\r\n")) == 70
    echo "All tests passed!"