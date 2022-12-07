func assertExpected*[T](expected, actual: T) =
    assert expected == actual, &"Expected {expected}, got {actual}"