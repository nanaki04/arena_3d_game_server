defmodule Arena.Flow.Harmony do

  use Arena.Map.Access
  alias Arena.Flow.Substance

  defstruct mark: 0,
    duelist_marks: %{}

  def harmonize(substance, well_substance_path, duelist) do
    get_in(substance, well_substance_path ++ [:harmony])
    |> (&get_in(&1, [:mark]) - get_in(&1, [:duelist_marks, duelist])).()
    |> (&Enum.take get_in(substance, well_substance_path ++ [:archive]), &1).()
    |> (&Substance.send_downstream substance, duelist, &1).()
  end

  def harmonize(substance, well_substance_path) do
    get_in(substance, well_substance_path ++ [:harmony, :duelist_marks])
    |> Enum.reduce(substance, fn {duelist, _}, acc -> harmonize acc, well_substance_path, duelist end)
  end

  def participate(substance, well_substance_path, duelist) do
    put_in substance, well_substance_path ++ [:harmony, :duelist_marks, duelist], 0
  end

  def pour(substance, well_substance_path) do
    update_in substance, well_substance_path ++ [:harmony, :mark], &(&1 + 1)
  end

end
