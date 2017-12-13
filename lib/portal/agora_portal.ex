defmodule Arena.Portal.Agora do
  use PathFinder.Footprints

  @node :self

  footprint :agora, [
    participate:  {@node, Arena.Flow.Agora, :participate},
    speak:        {@node, Arena.Flow.Agora, :speak},
  ]

end
