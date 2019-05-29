defmodule Miniredis.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Miniredis, []}
    ]

    opts = [strategy: :one_for_one, name: Miniredis.Supervisor]

    Supervisor.start_link(children, opts)
  end

end
