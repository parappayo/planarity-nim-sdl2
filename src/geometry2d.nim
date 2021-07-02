
type
  Point* = tuple
    x: float32
    y: float32

proc slope*(p1: Point, p2: Point): float32 =
  let dx = p2.x - p1.x
  if dx == 0:
    return NaN
  return (p2.y - p1.y) / dx
