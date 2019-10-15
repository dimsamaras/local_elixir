defmodule Snail do
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
      get_the_index([], matrix, 0, len - 1)
    end
  end

  def get_the_index(output, matrix, s, e) do
    Logger.debug("start: #{s}")
    Logger.debug("end: #{e}")

    cond do
      e - s > 0 ->
        Logger.debug("outer: #{e - s}")

        Logger.debug("east")
        # walk east
        output =
          Enum.reduce(s..e, output, fn i, output ->
            item =
              matrix
              |> Enum.at(s)
              |> Enum.at(i)

            output ++ [item]
          end)

        # walk down
        Logger.debug("down")

        output =
          Enum.reduce((s + 1)..e, output, fn i, output ->
            item =
              matrix
              |> Enum.at(i)
              |> Enum.at(e)

            output ++ [item]
          end)

        # walk west
        Logger.debug("west")

        output =
          Enum.reduce((e - 1)..s, output, fn i, output ->
            item =
              matrix
              |> Enum.at(e)
              |> Enum.at(i)

            output ++ [item]
          end)

        # walk up
        output =
          if e - s > 1 do
            Logger.debug("up")

            output =
              Enum.reduce((e - 1)..(s + 1), output, fn i, output ->
                item =
                  matrix
                  |> Enum.at(i)
                  |> Enum.at(s)

                output ++ [item]
              end)
          else
            output
          end

        get_the_index(output, matrix, s + 1, e - 1)

      e - s == 0 ->
        Logger.debug("last inner: #{e - s}")

        item =
          matrix
          |> Enum.at(e)
          |> Enum.at(e)

        output = output ++ [item]
        get_the_index(output, matrix, s + 1, e - 1)

      e - s < 0 ->
        Logger.debug("will print: #{e - s}")
        output
    end
  end
end
