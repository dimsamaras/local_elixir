defmodule SumOfIntevalsTest do
  use ExUnit.Case

  alias SumOfIntervals

  defp testing(a, exp) do
    act = SumOfIntervals.sum_of_intervals a
    assert act == exp, """
Given list #{inspect(a, charlists: :as_lists)}
Expected #{exp}, got #{act}
"""
  end

  test "basic tests" do
    testing [{1, 5}], 4
    testing [{1, 5}, {6, 10}], 8
    testing [{1, 5}, {1, 5}], 4
    testing [{1, 4}, {7, 10}, {3, 5}], 7
    testing [{48, 258}, {68, 348}, {-27, -19}, {-310, -241}, {-345, 428}, {228, 329}, {393, 499}, {-477, 192}, {64, 212}, {-301, 342}, {-450, -290}, {-141, 164}, {374, 471}, {-37, 354}, {268, 467}, {-154, 490}], 976
  end
end
