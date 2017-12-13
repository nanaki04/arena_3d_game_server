defmodule Arena.Flow.Canal.Agora do
  use Arena.Flow.Canal,
    well: Arena.Well.Agora

  @impl Arena.Flow.Canal
  def well_substance_path(substance) do
    [:agoras, well_id(substance)]
  end

  @impl Arena.Flow.Canal
  def well_id(substance) do
    substance.upstream.agora
  end
end
