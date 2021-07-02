import geometry2d

proc testSlope =
  let p1 = (0f, 0f)
  let p2 = (1f, 0f)
  let result = p1.slope(p2)
  doAssert(result == 0)

when isMainModule:
  testSlope()
