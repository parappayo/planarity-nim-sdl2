import math

type
  Point* = tuple
    x: float32
    y: float32

proc slope*(p1: Point, p2: Point): float32 =
  return (p2.y - p1.y) / (p2.x - p1.x)

proc slowIsClockwise*(p1: Point, p2: Point, p3: Point): bool =
  # Reference implementation; easy to grok, but does unnecessary branches and divides.
  # Handling of edge cases where points share an x-coordinate is different than is_clockwise.
  let slope1 = slope(p1, p2)
  let slope2 = slope(p1, p3)
  if classify(slope1) == fcInf or classify(slope1) == fcNegInf:
    return true
  return slope1 > slope2

proc isClockwise*(p1: Point, p2: Point, p3: Point): bool =
  return (p2.y - p1.y) * (p3.x - p1.x) > (p3.y - p1.y) * (p2.x - p1.x)
