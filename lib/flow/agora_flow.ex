defmodule Arena.Flow.Agora do
  use LifeBloom.Entangle,
    raindrops: [],
    vitalizers: [
      Arena.Flow.Canal.Agora
    ]

  alias Arena.Flow.Substance
  alias Arena.Flow.Harmony
  alias Arena.Flow

  entangle :participate, [
    branch(&upstream_to_well/1),
    branch(&enter/2, &participant/1),
    branch(&downstream_to_participants/1),
  ]

  entangle :speak, [
    branch(&upstream_to_well/1),
    branch(&downstream_to_participants/1),
  ]

  def agora(substance, key, val) when is_function(val, 1) and is_list(key),
  do: put_in substance, [:agoras, substance.upstream.agora] ++ key, val
  def agora(substance, key, val) when is_function(val, 1),
  do: update_in substance, [:agoras, substance.upstream.agora, key], val
  def agora(substance, key, val) when is_list(key),
  do: put_in substance, [:agoras, substance.upstream.agora] ++ key, val
  def agora(substance, key, val),
  do: put_in substance, [:agoras, substance.upstream.agora, key], val
  def agora(substance, key),
  do: get_in substance, [:agoras, substance.upstream.agora, key]

  def participant(substance),
  do: substance.upstream.participant

  def upstream_to_well(substance) do
    agora(substance, :archive, &[substance.upstream | &1])
    |> Harmony.pour([:agoras, substance.upstream.agora])
  end

  def downstream_to_participants(substance) do
    Harmony.harmonize(substance, [:agoras, substance.upstream.agora])
  end
  def parallel_downstream_to_participants(substance),
  do: (Flow.parallel_downstream(&downstream_to_participants/1)).(substance)

  def enter(substance, find_participant) do
    Harmony.participate substance, [:agoras, substance.upstream.agora], find_participant.(substance)
  end

end
