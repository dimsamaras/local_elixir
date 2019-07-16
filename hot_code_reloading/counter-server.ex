defmodule Counter do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, 0)
  end

  def init(state) do
    Process.send_after(self(), {:increment, 1}, 1000)
    {:ok, state}
  end

  # keep for backwards compatibility
  def handle_info(:increment, n) do
    handle_info({:increment, 2}, n)
  end

  def handle_info({:increment, value}, state) do
    incremented = state + value
    IO.puts("- #{inspect(self())}: #{incremented}")

    Process.send_after(self(), {:increment, 1}, 1000)

    {:noreply, incremented}
  end

  # when to reload the server code
  def code_change(_old_vsn, state, _extra) when rem(state, 2) == 1 do
    {:ok, state - 1}
  end

  def code_change(_old_vsn, state, _extra) do
    {:ok, state}
  end
end
