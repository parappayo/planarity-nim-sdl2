import game_state
import sdl2
import std/tables

type EventHandler* = proc (event: Event, gameState: var GameState)

var subscribers = initTable[EventType, ref seq[EventHandler]]()

proc addSubscriber*(eventType: EventType, handler: EventHandler) =
  if not subscribers.hasKey(eventType):
    subscribers[eventType] = new seq[EventHandler]
  subscribers[eventType][].add(handler)

proc handleEvent*(event: Event, gameState: var GameState) =
  if subscribers.hasKey(event.kind):
    for handler in subscribers[event.kind][]:
      handler(event, gameState)
