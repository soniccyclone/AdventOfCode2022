import strutils
import std/algorithm

let f = open("./src/day1/input")

var elves = newSeq[int]()

var elf = 0

for line in f.lines:
    if line == "":
        elves.add(elf)
        elf = 0
    else:
        elf += line.parseInt()

echo "Part 1: ", max(elves)

elves.sort()

echo "Part 1 but sorted: ", elves[^1]

echo "Part 2: ", elves[^1] + elves[^2] + elves[^3]