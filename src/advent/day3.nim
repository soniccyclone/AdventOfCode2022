import math, sets, sequtils, tables, sugar, strutils

# const alphabet = toSeq('a'..'z').concat(toSeq('A'..'Z')).enumerate.toTable
# would be far superior to the next two lines but enumerate requires it be
# used within a for loop...would also need to mess with indexes more with 
# that single line solution too I guess ¯\_(ツ)_/¯
const priority = toSeq('a'..'z').concat(toSeq('A'..'Z'))
const priorityLookup = zip(priority, toSeq(1..priority.len)).toTable

func getRucksackTotal(rucksack: string): int =
    let compartmentOne = toHashSet(rucksack[0..<rucksack.len.floorDiv(2)])
    let compartmentTwo = toHashSet(rucksack[rucksack.len.floorDiv(2)..^1])
    let sharedItems = compartmentOne * compartmentTwo
    sharedItems.map((item) => priorityLookup[item])
    .toSeq
    .sum

func getPrioritySum(file: string): int =
        file.split("\r\n")
        .map((rucksack) => getRucksackTotal(rucksack))
        .sum

func getBadgeSum(file: string): int =
    let lines = file.split("\r\n")
    # TODO: Write a macro for map that returns sequences of items based off of a step
    for i in countup(0, lines.len - 1, 3):
        # Assume file will always be divisible by three to form proper elven groups
        let elfOne = toHashSet(lines[i])
        let elfTwo = toHashSet(lines[i + 1])
        let elfThree = toHashSet(lines[i + 2])
        var badge =  elfOne * elfTwo * elfThree
        result += priorityLookup[badge.pop]

proc dayThree*(fileName: string) =
    echo "Day 3 Part 1: ", getPrioritySum(readFile(fileName))
    echo "Day 3 Part 2: ", getBadgeSum(readFile(fileName))

when isMainModule:
    assert getPrioritySum(readFile("src/input/day3.test")) == 157
    assert getBadgeSum(readFile("src/input/day3.test")) == 70
    echo "All tests passed!"