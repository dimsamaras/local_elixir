defmodule Counter do
  def count(n) do
    :timer.sleep(1000)
    IO.puts("- #{inspect(self())}: #{n}")
    count(n + 3)
  end
end
