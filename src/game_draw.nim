import game_state
import sdl2

proc drawPip(renderer: RendererPtr, pip: Pip) =
  let
    w = 20f
    h = 20f
  var r = rect(
      cint(pip.x), cint(pip.y),
      cint(pip.x + w), cint(pip.y + h))
  renderer.setDrawColor 255, 255, 255, 255 # white
  renderer.fillRect(r)

proc drawFrame*(renderer: RendererPtr, gameState: GameState) =
  renderer.setDrawColor 0, 0, 0, 255 # black
  renderer.clear()

  for pip in gameState.pips:
    drawPip(renderer, pip)

  renderer.present()
