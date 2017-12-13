defmodule Arena.Flow.Substance do

  use Arena.Map.Access

  @type substance :: %Arena.Flow.Substance{}

  defstruct upstream: nil,
    downstream: %{},
    parallels: %{upstream: [], downstream: []},
    duelists: %{},
    agoras: %{}

  def send_downstream(substance, charm),
  do: send_downstream substance, Arena.Flow.Duelist.duelist_name(substance), charm
  def send_downstream(substance, duelist, charms) when is_list(charms),
  do: Enum.reverse(charms) |> Enum.reduce(substance, &(send_downstream &2, duelist, &1))
  def send_downstream(substance, duelist, charm),
  do: update_in substance, [:downstream, duelist], &(update_downstream &1, charm)

  defp update_downstream(nil, charm), do: [charm]
  defp update_downstream(downstream, charm), do: [charm | downstream]

end
