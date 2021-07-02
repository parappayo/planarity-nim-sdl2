import math
import geometry2d

let Inff* = 1f / 0f
let NegInff = -1f / 0f

proc testSlope =
  let tests = [
    # (point1, point2, slope)
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
    let result = slope(p1, p2)
    if expected == Inff:
      doAssert classify(result) == fcInf
    elif expected == NegInff:
      doAssert classify(result) == fcNegInf
    else:
      doAssert result == expected

proc slowIsClockwise(p1: Point, p2: Point, p3: Point): bool =
  # Reference implementation; easy to grok, but does unnecessary branches and divides.
  # Handling of edge cases where points share an x-coordinate is different than is_clockwise.
  let slope1 = slope(p1, p2)
  let slope2 = slope(p1, p3)
  if classify(slope1) == fcInf or classify(slope1) == fcNegInf:
    return true
  return slope1 > slope2

proc testIsClockwise =
  let tests = [
    # (point1, point2, point3, isClockwise)
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
    doAssert result == expected
    doAssert result == slowIsClockwise(p1, p2, p3)

proc testValueAt =
  let tests = [
    # ((yIntercept, slope), x, valueAt)
    ((0f, 1f), 3f, 3f),
    ((0f, -1f), 3f, -3f),
    ((1f, 0f), 3f, 1f),
    ((-1f, 0f), 3f, -1f),
  ]
  for test in tests:
    let line = test[0]
    let x = test[1]
    let expected = test[2]
    let result = valueAt(line, x)
    doAssert result == expected

proc testIntersectionX =
  let tests = [
    # ((yIntercept, slope), (yIntercept, slope), intersectionX)
    ((0f, 0f), (-1f, 1f), 1f),
    ((0f, 0f), (-1f, 0f), Inff),
  ]
  for test in tests:
    let line1 = test[0]
    let line2 = test[1]
    let expected = test[2]
    let result = intersectionX(line1, line2)
    if expected == Inff:
      doAssert classify(result) == fcInf
    else:
      doAssert result == expected

proc testIntersection =
  let tests = [
    # ((yIntercept, slope), (yIntercept, slope), (x, y))
    ((0f, 0f), (-1f, 1f), (1f, 0f)),
    ((0f, 0f), (-1f, 0f), (Inff, Inff)),
  ]
  for test in tests:
    let line1 = test[0]
    let line2 = test[1]
    let expected = test[2]
    let result = intersection(line1, line2)
    if expected[0] == Inff:
      doAssert classify(result.x) == fcInf
    else:
      doAssert result == expected

when isMainModule:
  testSlope()
  testIsClockwise()
  testValueAt()
  testIntersectionX()
  testIntersection()
