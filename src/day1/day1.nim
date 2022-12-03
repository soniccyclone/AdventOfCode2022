import parseutils

let f = open("input")

var elves = newSeq[int]()

var elf = 0

for line in f.lines:
    if line == "":
        elves.add(elf)
        elf = 0
    else:
        let food = 0
        line.parseInt(food)
        elf += food

# should just need to return the max of elves