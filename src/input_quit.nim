import game_input
import game_state
import sdl2

proc onQuit(event: Event, gameState: var GameState) =
  gameState.running = false

proc quitInputInit*() =
  addSubscriber(QuitEvent, onQuit)
