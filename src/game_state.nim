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
    running*: bool
    lastFoundCollision*: (ref Edge, ref Edge)
    levelComplete: bool

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

proc findPip*(gameState: GameState, pos: tuple[x: float32, y: float32]): ref Pip =
  let radius = 24f  # depends on pip size
  for pip in gameState.pips:
    let
      dx = pip.x - pos.x
      dy = pip.y - pos.y
    if dx * dx + dy * dy < radius * radius:
      return pip
  nil

proc startLevel(game: var GameState, level: int) =
  let
    lineCount = level + 4
    level = generateLevel(lineCount)
  game.pips = level[0]
  game.edges = level[1]
  arrangeInCircle(game.pips, game.screenSize)

proc checkWinCondition*(game: var GameState) =
  if game.levelComplete:
    return
  for edge1 in game.edges:
    for edge2 in game.edges:
      if edge1 == edge2:
        continue
      if edge1[].intersects(edge2[]):
        game.lastFoundCollision = (edge1, edge2)
        return
  game.lastFoundCollision = (nil, nil)
  game.levelComplete = true

proc newGameState*(level: int, screenWidth: int, screenHeight: int): GameState =
  result = GameState(
    pips: newSeq[ref Pip](),
    edges: newSeq[ref Edge](),
    screenSize: (screenWidth, screenHeight),

    # set this to false and the program will exit on the next event loop
    running: true,

    lastFoundCollision: (nil, nil),
    levelComplete: false
  )
  startLevel(result, level)
