defmodule Arena.Well.Duelist do
  use Arena.Well

  @type duelist :: %Arena.Well.Duelist{}

  defstruct id: "",
    name: "",
    password: "",
    archive: [],
    harmony: %Arena.Flow.Harmony{}

  @impl Guardian.Secret
  def make_initial_state(id) do
    %Arena.Well.Duelist{id: id}
  end

end
