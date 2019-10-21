defmodule SnailOLD do
  @doc """

  Converts a matrix to a list by walking around its edges from the top-left going clockwise.

  ![snail walk](http://www.haan.lu/files/2513/8347/2456/snail.png)

  iex> Snail.snail( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ] )
  [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

  """

  require Logger

  @spec snail([[term]]) :: [term]

  def snail(matrix) do
    [hd | _tl] = matrix

    len = length(hd)

    if len == 0 do
      []
    else
      get_the_index([], 0, 0, matrix, 0, len, len)
    end
  end

  def get_the_index(output, row_index, col_index, matrix, s, n, len) do
    Logger.debug("row: #{row_index}")
    Logger.debug("col: #{col_index}")
    Logger.debug("start: #{s}")
    Logger.debug("end: #{n}")
    Logger.debug("size: #{len}")

    if 2 * s < len and length(output) < 4 * (n - s) do
      item =
        matrix
        |> Enum.at(row_index)
        |> Enum.at(col_index)

      output = output ++ [item]

      cond do
        # get the first row
        row_index == s and col_index < n - 1 ->
          get_the_index(output, row_index, col_index + 1, matrix, s, n, len)

        # get last column
        col_index == n - 1 and row_index < n - 1 ->
          get_the_index(output, row_index + 1, col_index, matrix, s, n, len)

        # get last row
        row_index == n - 1 and col_index > s ->
          get_the_index(output, row_index, col_index - 1, matrix, s, n, len)

        # get the first column
        row_index > s and col_index == s ->
          get_the_index(output, row_index - 1, col_index, matrix, s, n, len)
      end
    else
      output
    end
  end
end
