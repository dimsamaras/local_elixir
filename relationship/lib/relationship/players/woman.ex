defmodule Woman do
  @enforce_keys [:name]
  alias __MODULE__
  alias Protocols.Human

  defstruct name: ""

  def new(name) do
    %Woman{name: name}
  end
end

defimpl Human, for: Woman do
  def greet(_), do: "Hey"
  def talk(_), do: "miaoooou"
  def love(_), do: "<3<3<3"
end



