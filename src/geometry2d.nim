import math
import strformat

type
  Point* = tuple
    x: float32
    y: float32

  Line* = tuple
    yIntercept: float32
    slope: float32

  LineSegment* = tuple
    fromPoint: Point
    toPoint: Point

  Intersection* = ref object
    fromLine: Line
    toLine: Line
    atPoint*: Point

proc `$`*(line: Line): string =
  return &"(yIntercept: {line.yIntercept}, slope: {line.slope})"

proc `$`*(inter: Intersection): string =
  return &"(fromLine: {inter.fromLine}, toLine: {inter.toLine}, atPoint: {inter.atPoint})"

proc isInfinite*(x: float32): bool =
  return classify(x) == fcInf or classify(x) == fcNegInf

proc isInfOrNan*(x: float32): bool =
  let c = classify(x)
  return c == fcInf or c == fcNegInf or c == fcNan

proc slope*(p1: Point, p2: Point): float32 =
  return (p2.y - p1.y) / (p2.x - p1.x)

proc slope*(line: LineSegment): float32 =
  return slope(line.fromPoint, line.toPoint)

proc isClockwise*(p1: Point, p2: Point, p3: Point): bool =
  return (p2.y - p1.y) * (p3.x - p1.x) > (p3.y - p1.y) * (p2.x - p1.x)

proc valueAt*(line: Line, x: float32): float32 =
  return line.slope * x + line.yIntercept

proc intersectionX*(line1: Line, line2: Line): float32 =
  let dyIntercept = line2.yIntercept - line1.yIntercept
  let dSlope = line2.slope - line1.slope
  return -dyIntercept / dSlope

proc intersection*(line1: Line, line2: Line): Point =
  let x = intersectionX(line1, line2)
  let y = line1.valueAt(x)
  return (x, y)

proc sharesPoint*(line1: LineSegment, line2: LineSegment): bool =
  return line1.fromPoint == line2.fromPoint or
    line1.fromPoint == line2.toPoint or
    line1.toPoint == line2.fromPoint or
    line1.toPoint == line2.toPoint

proc intersects*(line1: LineSegment, line2: LineSegment): bool =
  if sharesPoint(line1, line2):
    # not correct but enough for a decent game of Planarity
    return false
  return (
    (isClockwise(line1.fromPoint, line2.fromPoint, line2.toPoint) !=
      isClockwise(line1.toPoint, line2.fromPoint, line2.toPoint)) and
    (isClockwise(line1.fromPoint, line1.toPoint, line2.fromPoint) !=
      isClockwise(line1.fromPoint, line1.toPoint, line2.toPoint)))

proc newIntersection*(fromLine: Line, toLine: Line): Intersection =
  Intersection(
    fromLine: fromLine,
    toLine: toLine,
    atPoint: intersection(fromLine, toLine)
  )

proc isValid*(point: Point): bool =
  return not isInfOrNan(point.x) and not isInfOrNan(point.y)

proc isValid*(inter: Intersection): bool =
  return isValid(inter.atPoint)
