import strutils
import std/algorithm

proc getElves(file: string): seq[int] = 
    let f = open(file)
    var elf = 0
    for line in f.lines:
        if line == "":
            result.add(elf)
            elf = 0
        else:
            elf += line.parseInt()
    f.close()

proc dayOne*(file: string) =
    var elves = getElves(file)
    echo "Part 1: ", max(elves)
    elves.sort()
    echo "Part 1 but sorted: ", elves[^1]
    echo "Part 2: ", elves[^1] + elves[^2] + elves[^3]