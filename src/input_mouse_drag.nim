import game_input
import game_state
import level_generator
import sdl2

var mouseDragTarget: ref Pip

proc onMouseButtonDown(event: Event, gameState: var GameState) =
  let pos = (x: float32(event.button.x), y: float32(event.button.y))
  mouseDragTarget = gameState.findPip(pos)

proc onMouseButtonUp(event: Event, gameState: var GameState) =
  mouseDragTarget = nil
  gameState.checkWinCondition()

proc onMouseMotion(event: Event, gameState: var GameState) =
  if mouseDragTarget == nil:
    return
  mouseDragTarget.x = float32(event.motion.x)
  mouseDragTarget.y = float32(event.motion.y)

proc init*() =
  addSubscriber(MouseButtonDown, onMouseButtonDown)
  addSubscriber(MouseButtonUp, onMouseButtonUp)
  addSubscriber(MouseMotion, onMouseMotion)
