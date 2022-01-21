import game_state
import level_generator
import sdl2

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

  for pip in gameState.pips:
    drawPip(renderer, pip)

  renderer.present()
