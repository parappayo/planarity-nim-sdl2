import sdl2

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

proc drawFrame(renderer: RendererPtr) =
  renderer.setDrawColor 0, 0, 0, 255 # black
  renderer.clear()

  renderer.setDrawColor 255, 255, 255, 255 # white
  var r = rect(
    cint(100), cint(100),
    cint(20), cint(20)
  )
  renderer.fillRect(r)

  renderer.present()

proc main =
  let
    init = initSdl()
    renderer = init[0]
    window = init[1]
  defer: sdl2.quit()
  defer: window.destroy()
  defer: renderer.destroy()

  var running = true

  while running:
    var event = defaultEvent

    while pollEvent(event):
      case event.kind
      of QuitEvent:
        running = false
        break
      else:
        discard

    drawFrame(renderer)

when isMainModule:
  main()
