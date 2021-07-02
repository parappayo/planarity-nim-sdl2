import geometry2d

proc testSlope =
  let testCases = [
    ((0f, 0f), (1f, 0f), 0f),
    ((0f, 0f), (1f, 1f), 1f),
    ((0f, 0f), (0f, 1f), NaNf),
    ((1f, 1f), (1f, 0f), NaNf),
    ((0f, 0f), (1f, 3f), 3f),
    ((0f, 0f), (-1f, 3f), -3f),
    ((0f, 0f), (-1f, -3f), 3f),
    ((1f, 1f), (2f, 2f), 1f),
    ((-1f, -1f), (-2f, -2f), 1f),
    ((1f, 1f), (2f, -2f), -3f),
  ]
  for testCase in testCases:
    let p1 = testCase[0]
    let p2 = testCase[1]
    let expected = testCase[2]
    let result = p1.slope(p2)
    doAssert(result == expected)

when isMainModule:
  testSlope()
