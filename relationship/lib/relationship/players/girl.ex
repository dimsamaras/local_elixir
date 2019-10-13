defmodule Girl do
  @enforce_keys [:name]
  alias __MODULE__
  alias Protocols.Human

  defstruct name: ""

  def new(name) do
    %Girl{name: name}
  end

end
