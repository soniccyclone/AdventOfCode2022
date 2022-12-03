import strutils
import std/algorithm

proc getElves(file: string): seq[int] = 
    var elf = 0
    for line in open(file).lines:
        if line == "":
            result.add(elf)
            elf = 0
        else:
            elf += line.parseInt()

proc dayOne*(file: string) =
    var elves = getElves(file)
    echo "Part 1: ", max(elves)
    elves.sort()
    echo "Part 1 but sorted: ", elves[^1]
    echo "Part 2: ", elves[^1] + elves[^2] + elves[^3]