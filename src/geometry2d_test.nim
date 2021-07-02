import math
import geometry2d

let Inff* = 1f / 0f
let NegInff = -1f / 0f

proc testSlope =
  let tests = [
    ((0f, 0f), (1f, 0f), 0f),
    ((0f, 0f), (1f, 1f), 1f),
    ((0f, 0f), (0f, 1f), Inff),
    ((1f, 1f), (1f, 0f), NegInff),
    ((0f, 0f), (1f, 3f), 3f),
    ((0f, 0f), (-1f, 3f), -3f),
    ((0f, 0f), (-1f, -3f), 3f),
    ((1f, 1f), (2f, 2f), 1f),
    ((-1f, -1f), (-2f, -2f), 1f),
    ((1f, 1f), (2f, -2f), -3f),
  ]
  for test in tests:
    let p1 = test[0]
    let p2 = test[1]
    let expected = test[2]
    let result = p1.slope(p2)
    if expected == Inff:
      doAssert classify(result) == fcInf
    elif expected == NegInff:
      doAssert classify(result) == fcNegInf
    else:
      doAssert result == expected

proc testIsClockwise =
  let tests = [
    ((0f, 0f), (0f, 0f), (0f, 0f), false),
    ((0f, 0f), (0f, 0f), (1f, 1f), false),
    ((0f, 0f), (0f, 0f), (1f, -1f), false),
    ((0f, 0f), (1f, 1f), (0f, 0f), false),
    ((0f, 0f), (1f, -1f), (0f, 0f), false),
    ((0f, 0f), (1f, 0f), (1f, -1f), true),
    ((0f, 0f), (1f, 0f), (1f, 1f), false),
    ((1f, 1f), (1f, 0f), (0f, 0f), true),
    ((5f, 5f), (6f, 4f), (5f, 3f), true),
    ((5f, 5f), (6f, 4f), (7f, 3f), false),
  ]
  for test in tests:
    let p1 = test[0]
    let p2 = test[1]
    let p3 = test[2]
    let expected = test[3]
    let result = isClockwise(p1, p2, p3)
    doAssert(result == expected)
    doAssert(result == slowIsClockwise(p1, p2, p3))

when isMainModule:
  testSlope()
  testIsClockwise()
