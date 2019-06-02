defmodule Miniredis do
  @moduledoc """
  Documentation for Miniredis.

  Redis-like implementation
  """
  use GenServer

  @doc """
  Client Interface
  """
  def start_link(opts \\ []) do
    GenServer.start(__MODULE__, opts, name: __MODULE__)
  end

  def set(key, value) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def get_all , do: GenServer.call(__MODULE__, :get_all)

  def keys , do: GenServer.call(__MODULE__, :keys)

  def set_async(key, value) do
    GenServer.cast(__MODULE__, {:set_async, key, value})
  end

  def die, do: GenServer.call(__MODULE__, :die)

  @doc """
  GenServer.init/1 callback
  """
  def init(_) do
    {:ok, %{}}
  end

  @doc """
  handle_call/3 callback implementations
  """
  def handle_call({:set, key, value}, _from, state) do
    {:reply, :ok, Map.merge(state, %{key => value})}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.fetch!(state, key), state}
  end

  def handle_call(:keys, _from, state) do
    {:reply, Map.keys(state), state}
  end

  def handle_call(:get_all, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:die, state) do
    {:reply, state, state}
  end

  @doc """
  handle_castl/2 callback implementations
  """
  def handle_cast({:set_async, key, value}, state) do
    {:noreply, Map.merge(state, %{key => value})}
  end

end
