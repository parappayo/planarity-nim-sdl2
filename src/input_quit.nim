import game_input
import game_state
import sdl2

proc onQuit(event: Event, gameState: var GameState) =
  gameState.running = false

proc onKeyDown(event: Event, gameState: var GameState) =
  if event.key.keysym.scancode == SDL_SCANCODE_ESCAPE:
    gameState.running = false

proc init*() =
  addSubscriber(QuitEvent, onQuit)
  addSubscriber(KeyDown, onKeyDown)
