defmodule Arena.Flow.Canal do

  @callback well_substance_path(Arena.Flow.Substance.substance) :: [atom | String.t]
  @callback well_id(Arena.Flow.Substance.substance) :: String.t

  defmacro __using__(opts) do
    quote bind_quoted: [opts: opts] do
      use LifeBloom.Vitalizer
      @behaviour Arena.Flow.Canal
      @behaviour LifeBloom.Vitalizer

      Module.register_attribute __MODULE__, :well, []
      @well Keyword.get(opts, :well)

      @impl LifeBloom.Vitalizer
      def vitalize(next) do
        fn substance ->
          apply(@well, :update, [well_id(substance), fn well_substance ->
            put_in(substance, well_substance_path(substance), well_substance)
            |> next.()
            |> Arena.Flow.converge_parallel_upstream
            |> (&{&1, get_in(&1, well_substance_path(&1))}).()
          end])
          |> Arena.Flow.converge_parallel_downstream
        end
      end

      @spec well_substance_path(Arena.Flow.Substance.substance) :: [atom | String.t]
      def well_substance_path(substance) do
        []
      end

      @spec well_id(Arena.Flow.Substance.substance) :: String.t
      def well_id(substance) do
        "0"
      end

      defoverridable [well_substance_path: 1, well_id: 1]
    end
  end

end
