import strutils, algorithm, sequtils, sugar, math

proc getElves(file: string): seq[int] = 
    var elf = 0
    for line in open(file).lines:
        if line == "":
            result.add(elf)
            elf = 0
        else:
            elf += line.parseInt()

proc getFunctionalElves(file: string): seq[int] =
    readFile(file)
     .split("\r\n\r\n")
     .map((elf) =>
         elf.split("\r\n")
         .map(parseInt)
         .sum())

proc dayOne*(file: string) =
    var elves = getElves(file)
    echo "Part 1: ", max(elves)
    elves.sort()
    echo "Part 1 but sorted: ", elves[^1]
    echo "Part 2: ", elves[^1] + elves[^2] + elves[^3]

    elves = getFunctionalElves(file)
    elves.sort()
    echo "Functional Part 1: ", elves[^1]
    echo "Functional Part 2: ", elves[^1] + elves[^2] + elves[^3]