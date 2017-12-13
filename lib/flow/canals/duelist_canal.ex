defmodule Arena.Flow.Canal.Duelist do
  use Arena.Flow.Canal,
    well: Arena.Well.Duelist

  @impl Arena.Flow.Canal
  def well_substance_path(substance) do
    [:duelists, well_id(substance)]
  end

  @impl Arena.Flow.Canal
  def well_id(substance) do
    substance.upstream.name
  end
end
