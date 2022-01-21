import math
import geometry2d
import level_generator

type
  Colour* = tuple
    r, g, b: int

  ScreenSize* = tuple
    width, height: int

  GameState* = object
    pips*: seq[ref Pip]
    edges*: seq[ref Edge]
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

proc arrangeInCircle(pips: var seq[ref Pip], screenSize: ScreenSize) =
  let
    center = (
      float32(screenSize.width) / 2f,
      float32(screenSize.height) / 2f
    )
    radius = float32(screenSize.height) / 2.5f

  var i = 0
  for destPoint in circlePoints(center, radius, len(pips)):
    pips[i].x = destPoint.x
    pips[i].y = destPoint.y
    i += 1

proc startLevel(game: var GameState, level: int) =
  let
    lineCount = level + 4
    level = generateLevel(lineCount)
  game.pips = level[0]
  game.edges = level[1]
  arrangeInCircle(game.pips, game.screenSize)

proc newGameState*(level: int, screenWidth: int, screenHeight: int): GameState =
  result = GameState(
    pips: newSeq[ref Pip](),
    edges: newSeq[ref Edge](),
    screenSize: (screenWidth, screenHeight)
  )
  startLevel(result, level)
