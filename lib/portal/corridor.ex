defmodule Arena.Portal.Corridor do
  use PathFinder.Gatekeeper

  def inspect(find) do
    fn clues ->
      update_in(clues.gifts, &[%Arena.Flow.Substance{upstream: hd &1}])
      |> find.()
      |> Map.update!(:result, &Map.get(&1, :downstream))
    end
  end
end
