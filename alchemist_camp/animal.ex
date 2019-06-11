
defprotocol Animal do
  @fallback_to_any true

  def greet(arg)
  def talk(arg)
  def warn(arg)
  defdelegate kind(arg), to: Animal.Any
  defdelegate describe(arg), to: Animal.Any
  defdelegate attributes(arg), to: Animal.Any
end

defimpl Animal, for: Any do
  def greet(_), do: ""
  def talk(_), do: ""
  def warn(_), do: ""

  def kind(animal) do
    animal.__struct__
    |> Module.split
    |> List.last
    |> String.downcase
  end

  def describe(animal) do
    IO.puts """
    This animal is a #{Animal.kind(animal)} named #{animal.name}.
    It says "#{Animal.warn(animal)} when it is scared"
    It says "#{Animal.talk(animal)} for his master"
    It says "#{Animal.greet(animal)} when it sees other animals "
    """
  end

  def attributes(animal) do
    IO.puts """
      For your #{animal.name} i have a total of #{count_attributes(animal)} attributes
    """
  end

  defp count_attributes(animal) do
    animal
    |> Map.keys
    |> Enum.count
  end
end

defimpl Animal, for: Dog do
  def greet(_), do: "woof"
  def talk(_), do: "woof woof"
  def warn(_), do: "GRRRRRRR!"
end

defimpl Animal, for: Cat do
  def greet(_), do: "..."
  def talk(_), do: "miaoooou"
  def warn(_), do: "HISSSS"
end

defmodule Dog do
  @enforce_keys [:name]
  alias __MODULE__

  defstruct name: ""

  def new(name) do
    %Dog{name: name}
  end
end

defmodule Cat do
  @enforce_keys [:name]
  alias __MODULE__

  defstruct name: ""

  def new(name) do
    %Cat{name: name}
  end
end

defmodule Duck do
  @enforce_keys [:name]
  alias __MODULE__

  defstruct name: ""

  def new(name) do
    %Duck{name: name}
  end
end
