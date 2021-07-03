import random
import geometry2d

proc rand(lowest: int, highest: int): int =
  rand(highest - lowest) + lowest

proc uniqRandInt*(lowest: int, highest: int, usedValues: var seq[int], maxRetries: int): int =
  result = rand(lowest, highest)
  var loopCount = 0
  while usedValues.contains(result):
    result = rand(lowest, highest)
    loopCount += 1
    if loopCount > maxRetries:
      raise newException(Exception, "Failed to generate unique random integer")
  usedValues.add(result)

proc randLine*(usedYIntercepts: var seq[int], usedSlopes: var seq[int]): Line =
  (
    yIntercept: float32(uniqRandInt(-1000, 1000, usedYIntercepts, 100)),
    slope: float32(uniqRandInt(-200, 200, usedSlopes, 100))
  )

proc generateLinesAndIntersections*(lineCount: int): (seq[Line], seq[Intersection]) =
  var lines = newSeq[Line]()
  var inters = newSeq[Intersection]()
  (lines, inters)
