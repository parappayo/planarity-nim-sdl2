
type
  Point* = tuple
    x: float32
    y: float32

proc slope*(p1: Point, p2: Point): float32 =
  return (p2.y - p1.y) / (p2.x - p1.x)

proc isClockwise*(p1: Point, p2: Point, p3: Point): bool =
  return (p2.y - p1.y) * (p3.x - p1.x) > (p3.y - p1.y) * (p2.x - p1.x)

type
  Line* = tuple
    yIntercept: float32
    slope: float32

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
