import game_draw
import game_input
import game_state
import input_mouse_drag
import input_quit
import sdl2
import sdl2/ttf

const
  WindowWidth = 800
  WindowHeight = 600

type SDLException = object of Defect

template sdlFailIf(condition: typed, reason: string) =
  if condition: raise SDLException.newException(
    reason & ", SDL error " & $getError()
  )

proc initSdl: (RendererPtr, WindowPtr) =
  sdlFailIf(not sdl2.init(INIT_VIDEO or INIT_TIMER or INIT_EVENTS)):
    "SDL2 initialization failed"

  let window = createWindow(
    title = "Planarity",
    x = SDL_WINDOWPOS_CENTERED,
    y = SDL_WINDOWPOS_CENTERED,
    w = WindowWidth,
    h = WindowHeight,
    flags = SDL_WINDOW_SHOWN
  )
  sdlFailIf window.isNil: "window could not be created"

  let renderer = createRenderer(
    window = window,
    index = -1,
    flags = Renderer_Accelerated or Renderer_PresentVsync or Renderer_TargetTexture
  )
  sdlFailIf renderer.isNil: "renderer could not be created"

  (renderer, window)

proc main =
  let
    init = initSdl()
    renderer = init[0]
    window = init[1]
  ttfInit()
  defer: ttfQuit()
  defer: sdl2.quit()
  defer: window.destroy()
  defer: renderer.destroy()

  game_draw.init(renderer)
  input_mouse_drag.init()
  input_quit.init()

  var gameState = newGameState(1, 800, 600)

  while gameState.running:
    var event = defaultEvent

    while pollEvent(event):
      handleEvent(event, gameState)

    drawFrame(renderer, gameState)

when isMainModule:
  main()
