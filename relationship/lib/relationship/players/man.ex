defmodule Man do
  @enforce_keys [:name]
  alias __MODULE__
  alias Protocols.Human

  defstruct name: ""

  def new(name) do
    %Man{name: name}
  end
end

defimpl Human, for: Man do
  def greet(_), do: "Hello"
  def talk(_), do: "Yo my nigga"
  def love(_), do: "GRRRRRRR!"
end
