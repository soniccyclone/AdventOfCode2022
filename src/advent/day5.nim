import sequtils, strutils, math, system/iterators, ../testHelpers

const crateIdentifierSpacing = 4 # number of characters in the input file that each crate takes up
const crateStartIndex = 1 # number of characters between each crate


iterator reverse*[T](a: seq[T]): T {.inline.} =
    var i = len(a) - 1
    while i > -1:
        yield a[i]
        dec(i)

proc partOne(file: string): string =
    let segments = file.split("\r\n\r\n")

    let stackLines = segments[0].split("\r\n")
    var stacks = newSeq[seq[char]](floorDiv(stackLines[0].len + 1, crateIdentifierSpacing))
    for line in stackLines:
        var stackIndex = 0
        for i in countup(crateStartIndex, line.len - 1, crateIdentifierSpacing):
            if isAlphaAscii(line[i]):
                stacks[stackIndex].add(line[i])
            inc(stackIndex)

    for line in segments[1].split("\r\n"):
        let cratesToMove = line.split(" ")[1].parseInt
        let source = line.split(" ")[3].parseInt - 1
        let destination = line.split(" ")[5].parseInt - 1

        for i in 0..<cratesToMove:
            stacks[destination] = stacks[source][0] & stacks[destination]
            stacks[source] = stacks[source][1..^1]

    return stacks.mapIt(it[0]).join

proc partTwo(file: string): string =
    let segments = file.split("\r\n\r\n")

    let stackLines = segments[0].split("\r\n")
    var stacks = newSeq[seq[char]](floorDiv(stackLines[0].len + 1, crateIdentifierSpacing))
    for line in stackLines:
        var stackIndex = 0
        for i in countup(crateStartIndex, line.len - 1, crateIdentifierSpacing):
            if isAlphaAscii(line[i]):
                stacks[stackIndex].add(line[i])
            inc(stackIndex)

    for line in segments[1].split("\r\n"):
        let cratesToMove = line.split(" ")[1].parseInt
        let source = line.split(" ")[3].parseInt - 1
        let destination = line.split(" ")[5].parseInt - 1

        stacks[destination] = stacks[source][0..<cratesToMove] & stacks[destination]
        stacks[source] = stacks[source][cratesToMove..^1]

    return stacks.mapIt(it[0]).join

proc testDayFive*(testFilePath: string) =
    let test = readFile(testFilePath)
    assertExpected("CMZ", partOne(test))
    assertExpected("MCD", partTwo(test))

proc dayFive*(filePath: string) =
    echo "Day 5 Part 1: ", partOne(readFile(filePath))
    echo "Day 5 Part 2: ", partTwo(readFile(filePath))