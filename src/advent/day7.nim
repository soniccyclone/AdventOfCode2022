import strutils, std/sets, system/iterators, ../testHelpers

# TODO: something using proper type theory/object oriented design
type
    ComFile = ref object
        parent: ComFile
        children: seq[ComFile]
        name: string
        isDir: bool
        size: int

proc processCommand(command: string, tree: ComFile) =
    discard

func createDirectoryTree(stream: seq[string]): int =
    # Just manually setup root node for now and ignore first line of input
    var tree =  ComFile(name: "/", isDir: true)
    var i = 1
    while i < stream.len:
        let line = stream[i]
        if line == "$ ls":
            var currentDirLines = newSeq[string]()
            tree.data = FileData(name: line[4..^1],
                isDir: true,
                size: 0)
            # Loop through the next lines until we hit the next command line

func partOne(stream: seq[string]): int =
    0

func partTwo(stream: seq[string]): int =
    0

proc testDaySeven*(testFilePath: string) =
    echo readFile(testFilePath).split("\r\n")
    let file = readFile(testFilePath).split("\r\n")
    assertExpected(95437, partOne(file))
    assertExpected(1, partTwo(file))

proc daySeven*(filePath: string) =
    let file = readFile(filePath).split("\r\n")
    echo "Day 7 Part 1: ", partOne(file)
    echo "Day 7 Part 2: ", partTwo(file)