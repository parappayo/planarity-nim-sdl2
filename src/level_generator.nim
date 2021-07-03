import random
import sequtils
import sets
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
  var
    lines = newSeq[Line]()
    inters = newSeq[Intersection]()
    usedYIntercepts = newSeq[int]()
    usedSlopes = newSeq[int]()

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

proc pointNeighbourPairs*(lines: seq[Line], inters: seq[Intersection]): (HashSet[Point], seq[LineSegment]) =
  var
    points = newSeq[Point]()
    connections = newSeq[LineSegment]()

  for line in lines:
    let pointsOnLine = pointsAlongLine(line, inters)
    if len(pointsOnLine) < 1: continue
    var
      previousPoint = pointsOnLine[0]
      firstLoop = true
    for point in pointsOnLine:
      points.add(point)
      if not firstLoop:
        connections.add((previousPoint, point))
      previousPoint = point
      firstLoop = false

  (points.toHashSet(), connections)

proc generateLevel*(lineCount: int): (HashSet[Point], seq[LineSegment]) =
  let linesAndInters = generateLinesAndIntersections(lineCount)
  pointNeighbourPairs(linesAndInters[0], linesAndInters[1])
