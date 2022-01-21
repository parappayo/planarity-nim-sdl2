import game_input
import game_state
import level_generator
import sdl2

# var mouseDragTarget: ref Pip

proc onMouseButtonDown(event: Event, gameState: var GameState) =
  echo("onMouseButtonDown=", event.button.x)

proc onMouseButtonUp(event: Event, gameState: var GameState) =
  echo("onMouseButtonUp=", event.button.x)

proc onMouseMotion(event: Event, gameState: var GameState) =
  echo("onMouseMotion=", event.motion.x)

proc init*() =
  addSubscriber(MouseButtonDown, onMouseButtonDown)
  addSubscriber(MouseButtonUp, onMouseButtonUp)
  addSubscriber(MouseMotion, onMouseMotion)
