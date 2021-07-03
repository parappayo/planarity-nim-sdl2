import random
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
  doAssert false # not implemented

when isMainModule:
  randomize() # non-deterministic tests, sorry about that
  testUniqRandInt()
  testRandLine()
  testGenerateLinesAndIntersections()
