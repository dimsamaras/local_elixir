defmodule Relationship do
  @moduledoc false
  use GenStateMachine

  ### Client API

  def start_new() do
    GenStateMachine.start_link(__MODULE__, {:new, %{man: nil, woman: nil, boy: nil, girl: nil}})
  end

  @doc """
  relationship is the pid
  """
  def get_status(relationship)do
    GenStateMachine.call(relationship, :get_status)
  end

  ### Server API

  def handle_event({:call, from}, :get_status, state, data) do
    {:next_state, state, data, [{:reply, from, state}]}
  end

end
