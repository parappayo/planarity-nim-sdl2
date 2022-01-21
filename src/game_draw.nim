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
    w = cint(20)
    h = cint(20)
  var r = rect(cint(pip.x), cint(pip.y), w, h)
  renderer.setDrawColor 255, 255, 255, 255 # white
  renderer.fillRect(r)

proc drawFrame*(renderer: RendererPtr, gameState: GameState) =
  renderer.setDrawColor 0, 0, 0, 255 # black
  renderer.clear()

  for edge in gameState.edges:
    renderer.drawEdge(edge[])

  for pip in gameState.pips:
    renderer.drawPip(pip[])

  renderer.present()
