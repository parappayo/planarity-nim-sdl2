import random
import level_generator

proc testUniqRandInt =
  randomize() # non-deterministic test, sorry about that
  var usedValues = @[1]
  let result = uniqRandInt(1, 2, usedValues, 100)
  doAssert result == 2
  doAssert usedValues == @[1, 2]

when isMainModule:
  testUniqRandInt()
