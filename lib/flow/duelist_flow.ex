defmodule Arena.Flow.Duelist do
  use LifeBloom.Entangle,
    raindrops: [],
    vitalizers: [
      Arena.Flow.Canal.Duelist
    ]

  import Arena.Flow
  import Arena.Flow.Substance
  alias Arena.Flow.Harmony

  entangle :view, [
    branch(&(&1)),
  ]

  entangle :login, [
    branch(parallel_upstream_to_well()),
    branch(&verify_password/1),
  ]

  def duelist(substance),
  do: get_in substance, [:duelists, substance.upstream.name]
  def duelist(substance, key, val) when is_function(val, 1),
  do: update_in substance, [:duelists, substance.upstream.name, key], val
  def duelist(substance, key, val),
  do: put_in substance, [:duelists, substance.upstream.name, key], val
  def duelist(substance, key),
  do: get_in substance, [:duelists, substance.upstream.name, key]

  def duelist_name(substance) do
    duelist(substance, :name)
    |> (case() do
      "" -> substance.upstream.name
      name -> name
    end)
  end

  def duelist_password(substance), do: duelist substance, :password
  def duelist_password(substance, val), do: duelist substance, :password, val

  def duelist_archive(substance), do: duelist substance, :archive
  def duelist_archive(substance, val), do: duelist substance, :archive, val

  def upstream_to_well(substance) do
    duelist_archive(substance, &[substance.upstream | &1])
    |> Harmony.pour([:duelists, substance.upstream.name])
  end
  def parallel_upstream_to_well(),
  do: parallel_upstream(&upstream_to_well/1, &duelist_archive/1, &duelist_archive/2)

  defp verify_password(substance) do
    substance
    |> duelist_password
    |> verify_password(substance.upstream.password)
    |> (&send_login_result(substance, &1)).()
  end
  defp verify_password("", _), do: :ok
  defp verify_password(stored, given),
  do: if given == stored, do: :ok, else: :failed

  defp send_login_result(substance, :ok) do
    substance
    |> duelist_password(substance.upstream.password)
    |> send_downstream(%Arena.Charm.LoginOk{name: substance.upstream.name})
  end
  defp send_login_result(substance, :failed),
  do: send_downstream(substance, %Arena.Charm.LoginFailed{})

end
