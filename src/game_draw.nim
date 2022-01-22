import game_state
import level_generator
import sdl2

proc drawEdge(renderer: RendererPtr, edge: Edge) =
  renderer.setDrawColor 255, 255, 255, 255 # white
  renderer.drawLine(
    cint(edge.fromPip.x), cint(edge.fromPip.y),
    cint(edge.toPip.x), cint(edge.toPip.y))

proc drawPip(renderer: RendererPtr, pip: Pip) =
  let
    halfWidth = cint(12)
    halfHeight = cint(12)
    borderThickness = cint(2)

  var
    outerRect = rect(
      cint(pip.x) - halfWidth, cint(pip.y) - halfHeight,
      halfWidth * 2, halfHeight * 2)
    innerRect = rect(
      outerRect.x + borderThickness, outerRect.y + borderThickness,
      outerRect.w - (borderThickness * 2), outerRect.h - (borderThickness * 2))

  renderer.setDrawColor 255, 255, 255, 255 # white
  renderer.fillRect(outerRect)
  renderer.setDrawColor 196, 196, 196, 255 # grey
  renderer.fillRect(innerRect)

proc drawFrame*(renderer: RendererPtr, gameState: GameState) =
  renderer.setDrawColor 0, 0, 0, 255 # black
  renderer.clear()

  for edge in gameState.edges:
    renderer.drawEdge(edge[])

  for pip in gameState.pips:
    renderer.drawPip(pip[])

  renderer.present()
