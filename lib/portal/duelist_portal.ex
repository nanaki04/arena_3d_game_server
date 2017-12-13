defmodule Arena.Portal.Duelist do
  use PathFinder.Footprints

  @node :self

  footprint :duelist, [
    login: {@node, Arena.Flow.Duelist, :login},
  ]

end
