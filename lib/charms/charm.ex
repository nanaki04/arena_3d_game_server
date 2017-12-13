defmodule Arena.Charm do

  @type charm_mark :: %Arena.Charm{}

  defstruct id: "",
    caster: "",
    initiation: 0,
    mark: 0

  def new_mark() do
    %Arena.Charm{
      caster: "game_server",
      initiation: System.system_time(:millisecond),
    }
  end
end
