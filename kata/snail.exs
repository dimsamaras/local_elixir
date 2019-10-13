defmodule Snail do

  @doc """

  Converts a matrix to a list by walking around its edges from the top-left going clockwise.

  ![snail walk](http://www.haan.lu/files/2513/8347/2456/snail.png)

  iex> Snail.snail( [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ] )
  [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

  """

  @spec snail( [ [ term ] ] ) :: [ term ]

  def snail( matrix ) do
    [hd|_tl] = matrix

    n = length(hd)
    if n == 0 do
      []
    else
      get_the_index([], 0, 0, matrix, n)
    end
  end

  def get_the_index(output, row_index, col_index, matrix, n) do
    if row_index >= 0 do
      item =
      matrix
      |> Enum.at(row_index)
      |> Enum.at(col_index)

      output = output ++ [item]

      cond do
        # get the first row
        row_index == 0 and col_index < n-1 -> get_the_index(output, row_index, col_index + 1, matrix, n)
        # get last column
        col_index == n-1 and row_index < n-1 -> get_the_index(output, row_index+1, col_index, matrix, n)
        # get last row
        row_index == n-1 and col_index > 0 -> get_the_index(output, row_index, col_index-1, matrix, n-1)
        # get the first column
        row_index == n-1 and col_index == 0 -> get_the_index(output, row_index-1, col_index, matrix, n-1)
      end
    else
      # start over with inner array
      get_the_index(output, 0, 0, matrix, n-1)
    end
  end
end
