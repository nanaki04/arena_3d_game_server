defmodule Arena.Well do

  defmacro __using__(_opts) do
    quote do

      use Arena.Map.Access
      use Guardian.Secret
      @behaviour Guardian.Secret # TODO add in library use macro
      import Arena.Well

      @type state :: map
      @type reply :: any
      @type updater :: (state -> {reply, state})
      @type id :: String.t

      @spec update(String.t, updater) :: state
      def update(id, updater) do
        :ok = guard(id)
        call id, {:update, updater}
      end

      def handle_call({:update, updater}, _from, state) do
        apply(updater, [state])
        |> Tuple.insert_at(0, :reply)
      end

    end
  end

end
