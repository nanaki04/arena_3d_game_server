defmodule Arena.Map.Access do

  defmacro __using__(_opts) do
    quote do

      @behaviour Access

      @impl Access
      def get_and_update(data, key, function) do
        Map.get_and_update(data, key, function)
      end

      @impl Access
      def fetch(data, key) do
        Map.fetch(data, key)
      end

      @impl Access
      def get(data, key, default) do
        Map.get(data, key, default)
      end

      @impl Access
      def pop(data, key) do
        Map.pop(data, key)
      end

    end
  end

end
