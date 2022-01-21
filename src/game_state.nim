import math
import geometry2d
import level_generator
import sets

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

proc toPips(points: HashSet[Point]): seq[Pip] =
  result = newSeq[Pip]()
  for point in points:
    result.add(Pip(x: point.x, y: point.y))

proc toEdges(connections: seq[LineSegment]): seq[Edge] =
  result = newSeq[Edge]()

proc startLevel(game: var GameState, level: int) =
  let
    lineCount = level + 4
    level = generateLevel(lineCount)
    points = level[0]
    connections = level[1]
  game.pips = toPips(points)
  game.edges = toEdges(connections)
  arrangeInCircle(game.pips, game.screenSize)

proc newGameState*(level: int, screenWidth: int, screenHeight: int): GameState =
  result = GameState(
    pips: newSeq[Pip](),
    edges: newSeq[Edge](),
    screenSize: (screenWidth, screenHeight)
  )
  startLevel(result, level)
