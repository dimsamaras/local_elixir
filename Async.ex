defmodule AsyncMath do

  def start() do
    receive do
      {:sum, [x, y], pid} -> send pid, {:result, add(x, y)}
    end
    start
  end

  defp add(a, b) do
    a + b
  end
end
