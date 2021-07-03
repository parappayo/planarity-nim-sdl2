import math
import geometry2d
import level_generator

type
  Colour* = tuple
    r, g, b: int

  ScreenSize* = tuple
    width, height: int

  Pip* = object
    x*, y*: float32

  Edge* = object
    fromPip*, toPip*: Pip

  GameState* = object
    pips*: seq[Pip]
    edges*: seq[Edge]
    backgroundColour*: Colour
    screenSize*: ScreenSize

iterator circlePoints(center: Point, radius: float32, pointCount: int): Point =
  var theta = 0f
  let thetaStep = float32(TAU) / float32(pointCount)
  for i in 0 ..< pointCount:
    yield (
      center.x + cos(theta) * radius,
      center.y + sin(theta) * radius
    )
    theta += thetaStep

proc arrangeInCircle(pips: seq[Pip], screenSize: ScreenSize) =
  let
    center = (
      float32(screenSize.width) / 2f,
      float32(screenSize.height) / 2f
    )
    radius = float32(screenSize.height) / 2.5f

  var i = 0
  for destPoint in circlePoints(center, radius, len(pips)):
    var pip = pips[i]
    i += 1
    pip.x = destPoint[0]
    pip.y = destPoint[1]

# proc startLevel*(game: var GameState, level: int) =
#   let
#     lineCount = level + 4
#     newLevel = generateLevel(lineCount)
#   game.pips = toPips(newLevel[0])
#   game.edges = toEdges(newLevel[1])
#   arrangeInCircle(game.pips, game.screenSize)

# proc newGameState*(level: int) =
#   result = GameState(
#     pips: newSeq[Pip](),
#     game.edges: newSeq[Edge](),
#     screenSize: (800, 600)
#   )
#   startLevel(result, level)
