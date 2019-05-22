defmodule MyProject do

  @spec add(number(), number()) :: number()
  def add(a,b) do
    a + b
  end

  @spec add(number(), number()) :: number()
  def subtract(a,b) do
    a - b
  end

  def list_length([]), do: 0
  def list_length([_ | tail]), do: 1 + list_length(tail)

  def hello(names, lang \\ "en")

  def hello(names, lang) when is_list(names) do
    names
    |> Enum.join(", ")
    |> hello
  end

  def hello(name, lang) when is_binary(name) do
    phrase(lang) <> name
  end

  defp phrase("en"), do: "Hello, "
  defp phrase("es"), do: "Hola, "
  defp phrase("fr"), do: "Allo, "
  defp phrase("gr"), do: "Χαίρεται, "
end
