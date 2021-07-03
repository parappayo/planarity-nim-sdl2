import random
import sets
import geometry2d
import level_generator

proc testUniqRandInt =
  var usedValues = @[1]
  let result = uniqRandInt(1, 2, usedValues, 100)
  doAssert result == 2
  doAssert usedValues == @[1, 2]

proc testRandLine =
  var usedYIntercepts = newSeq[int]()
  var usedSlopes = newSeq[int]()
  let result = randLine(usedYIntercepts, usedSlopes)
  doAssert len(usedYIntercepts) == 1
  doAssert len(usedSlopes) == 1
  doAssert isValid(result)

proc testGenerateLinesAndIntersections =
  let result = generateLinesAndIntersections(5)
  let lines = result[0]
  let inters = result[1]
  for line in lines:
    doAssert line.isValid()
  for inter in inters:
    doAssert inter.isValid()
  doAssert len(lines) == 5
  doAssert len(inters) > 5

proc testPointsAlongLine =
  let linesAndIntersections = generateLinesAndIntersections(5)
  let lines = linesAndIntersections[0]
  let inters = linesAndIntersections[1]
  let result = pointsAlongLine(lines[0], inters)
  doAssert len(result) > 0

proc testPointNeighbourPairs =
  let linesAndIntersections = generateLinesAndIntersections(5)
  let lines = linesAndIntersections[0]
  let inters = linesAndIntersections[1]
  let result = pointNeighbourPairs(lines, inters)
  let points = result[0]
  let connections = result[1]
  doAssert len(points) > 5
  doAssert len(connections) > 5

proc testGenerateLevel =
  let result = generateLevel(5)
  let points = result[0]
  let connections = result[1]
  doAssert len(points) > 5
  doAssert len(connections) > 5

when isMainModule:
  randomize() # non-deterministic tests, sorry about that
  testUniqRandInt()
  testRandLine()
  testGenerateLinesAndIntersections()
  testPointsAlongLine()
  testPointNeighbourPairs()
  testGenerateLevel()
