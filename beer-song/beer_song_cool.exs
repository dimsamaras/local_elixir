defmodule Beer do
  @doc """
  Sings all the verses in the supplied range.
  """
  def lyrics(range) when is_range(range) do
    Enum.map_join(range, "\n", verse &1) <> "\n"
  end

  @doc """
  Sings all the verses from start to finish
  """
  def lyrics(start, finish // 99) do
    lyrics start..finish
  end

  @doc """
  Returns the number of bottles of beer on the wall.
  """
  def verse(bottles) when bottles >= 0 do
    "#{how_many? bottles}\n#{take_one_down bottles}\n"
  end

  defp how_many?(bottles) do
    case bottles do
      0 -> "No more bottles of beer on the wall, no more bottles of beer."
      1 -> "1 bottle of beer on the wall, 1 bottle of beer."
      _ -> "#{bottles} bottles of beer on the wall, #{bottles} bottles of beer."
    end
  end

  defp take_one_down(bottles) do
    case bottles do
      0 -> "Go to the store and buy some more, 99 bottles of beer on the wall."
      1 -> "Take it down and pass it around, no more bottles of beer on the wall."
      2 -> "Take one down and pass it around, 1 bottle of beer on the wall."
      _ -> "Take one down and pass it around, #{bottles - 1} bottles of beer on the wall."
    end
  end
end