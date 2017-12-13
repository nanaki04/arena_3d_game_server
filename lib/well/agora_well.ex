defmodule Arena.Well.Agora do
  use Arena.Well

  @type agora :: %Arena.Well.Agora{}

  defstruct id: "",
    archive: [],
    harmony: %Arena.Flow.Harmony{}

  @impl Guardian.Secret
  def make_initial_state(id) do
    %Arena.Well.Agora{id: id}
  end

end
