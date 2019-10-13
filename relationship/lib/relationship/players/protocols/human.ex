
defprotocol Human do
  @fallback_to_any true

  def greet(arg)
  def talk(arg)
  def love(arg)
  defdelegate kind(arg), to: Human.Any
  defdelegate describe(arg), to: Human.Any
  defdelegate attributes(arg), to: Human.Any
end

defimpl Human, for: Any do
  def greet(_), do: ""
  def talk(_), do: ""
  def love(_), do: ""

  def kind(animal) do
    animal.__struct__
    |> Module.split
    |> List.last
    |> String.downcase
  end

  def describe(animal) do
    IO.puts """
    This animal is a #{Human.kind(animal)} named #{animal.name}.
    It says "#{Human.love(animal)} when it is feelinf the love"
    It says "#{Human.talk(animal)} to his/her friend"
    It says "#{Human.greet(animal)} when sees other people"
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
