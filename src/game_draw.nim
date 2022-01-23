import game_state
import level_generator
import sdl2
import sdl2/ttf

var font: FontPtr
var youWinSurface: SurfacePtr
var youWinText: TexturePtr

proc drawEdge(renderer: RendererPtr, edge: Edge) =
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
    if edge == gameState.lastFoundCollision[0] or
      edge == gameState.lastFoundCollision[1]:
      renderer.setDrawColor 255, 0, 0, 255 # red
    else:
      renderer.setDrawColor 255, 255, 255, 255 # white
    renderer.drawEdge(edge[])

  for pip in gameState.pips:
    renderer.drawPip(pip[])

  if gameState.levelComplete:
    let
      textWidth = youWinSurface.w
      textHeight = youWinSurface.h
      srcRect = rect(0, 0, textWidth, textHeight)
      destRect = rect(
        cint((gameState.screenSize.width - textWidth) div 2), cint((gameState.screenSize.height - textHeight) div 2),
        textWidth, textHeight)
    renderer.copy(youWinText, srcRect.unsafeAddr, destRect.unsafeAddr)

  renderer.present()

proc init*(renderer: RendererPtr) =
  font = openFont("Roboto-Bold.ttf", 32)
  if font == nil:
    echo("font failed to load")

  let white = color(255, 255, 255, 255)
  youWinSurface = renderTextSolid(font, "Level Complete", white)
  youWinText = renderer.createTextureFromSurface(youWinSurface)
