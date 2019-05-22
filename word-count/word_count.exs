defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    list = sentence
    |> String.replace(~r/[,.:"@£$%^&*!]/, " ")
    |> String.downcase()
    |> String.split(~r/[ _]+/, trim: true)
    # |> String.split(~r{(\\n|[^\w'-])+})
    # |> String.split(" ")
    |> Enum.filter(fn x -> x != "" end)
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end
end
