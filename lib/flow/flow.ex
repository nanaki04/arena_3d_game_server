defmodule Arena.Flow do

  def parallel_upstream(surge, get, put) do
    fn substance ->
      Task.Supervisor.async(Arena.Task.Supervisor, fn () -> surge.(substance) end)
      |> (&put_in substance.parallels.upstream, [{get, put, &1} | substance.parallels.upstream]).()
    end
  end

  def parallel_downstream(surge), do: parallel_downstream surge, &(&1), fn _, new -> new end
  def parallel_downstream(surge, get, put) do
    fn substance ->
      Task.Supervisor.async(Arena.Task.Supervisor, fn () -> surge.(substance) end)
      |> (&put_in substance.parallels.downstream, [{get, put, &1} | substance.parallels.downstream]).()
    end
  end

  def converge_parallel_upstream(substance) do
    Enum.reduce(substance.parallels.upstream, substance, &await/2)
    |> (&put_in &1, [:parallels, :upstream], []).()
  end

  def converge_parallel_downstream(substance) do
    Enum.reduce(substance.parallels.downstream, substance, &await/2)
    |> (&put_in &1, [:parallels, :downstream], []).()
  end

  defp await({get, put, task}, substance) do
    Task.await(task)
    |> (&put.(substance, get.(&1))).()
  end

end
