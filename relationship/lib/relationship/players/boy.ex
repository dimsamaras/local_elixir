defmodule Boy do
  @enforce_keys [:name]
  alias __MODULE__
  alias Protocols.Human

  defstruct name: ""

  def new(name) do
    %Boy{name: name}
  end
end
