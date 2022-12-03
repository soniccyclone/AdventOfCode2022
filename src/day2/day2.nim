
proc getScore(file: File): int =
    0

when isMainModule:
    block:
        let data = open("src/day2/test.in")
        assert getScore(data) == 15
        echo "All tests passed!"