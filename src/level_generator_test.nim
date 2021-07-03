import random
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
  echo result

when isMainModule:
  randomize() # non-deterministic tests, sorry about that
  testUniqRandInt()
  testRandLine()
