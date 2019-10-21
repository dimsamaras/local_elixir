defmodule SumOfIntervals do

  require Logger

  def sum_of_intervals_a(a) do
    out =
    a
    |> Enum.sort()
    |> Enum.reduce(%{sum: 0, end: -576460752303423489}, fn {s, e}, acc ->

      cond do
      acc.end >= s and acc.end >= e -> acc
      acc.end >= s and acc.end < e ->
        new_sum = acc.sum + (e - acc.end)
        %{sum: new_sum, end: e}
      acc.end < s ->
        new_sum = acc.sum + (e - s)
        %{sum: new_sum, end: e}
      end

    end)

    out.sum
  end

  def sum_of_intervals(a) do
    # a = [{start, end}, {start, end}, {s, e}]
    a
    |> Enum.reduce(MapSet.new(), fn {s, e}, acc ->
      # convert in range to unfold values
      # so we can create the mapset union
      # and count the items in the end
      Range.new(s, e - 1)
      |> MapSet.new()
      |> MapSet.union(acc)
    end)
    |> Enum.count()
  end

  def sum_of_intervals_c(a), do: a |> Enum.flat_map(fn x -> elem(x, 0)..elem(x, 1) - 1 end) |> Enum.uniq |> Enum.count
end
