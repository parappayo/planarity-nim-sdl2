import random
import sequtils
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
  var usedYIntercepts = newSeq[int]()
  var usedSlopes = newSeq[int]()

  for i in 1..lineCount:
    let line = randLine(usedYIntercepts, usedSlopes)
    for oldLine in lines:
      let inter = newIntersection(line, old_line)
      if inter.isValid():
        inters.add(inter)
    lines.add(line)

  (lines, inters)

proc pointsAlongLine*(line: Line, inters: seq[Intersection]): seq[Point] =
  let intersOnLine = inters.filter(
    proc(inter: Intersection): bool = inter.isOnLine(line))
  intersOnLine.map(
    proc(inter: Intersection): Point = inter.atPoint)
