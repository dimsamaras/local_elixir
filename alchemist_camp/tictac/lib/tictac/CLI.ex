defmodule Tictac.CLI do
  alias Tictac.{State, CLI}

  def play() do
    Tictac.start(&CLI.handle/2)
  end

  def handle(%State{status: initial}, :get_player) do
    IO.gets("Which player should start, x or o?")
    |> String.trim
    |> String.to_atom
  end

  defp show(board, r, c) do
    [item] = for {%{col: col, row: row}, v} <- board,
              col == c, row == r,
              do: v
    if item == :empty, do: " ", else: to_string(item)
  end

  def display_board(board) do
    IO.puts """
    #{show(board, 1, 1)} | #{show(board, 1, 2)} | #{show(board, 1, 3)}
    ---------
    #{show(board, 2, 1)} | #{show(board, 2, 2)} | #{show(board, 2, 3)}
    ---------
    #{show(board, 3, 1)} | #{show(board, 3, 2)} | #{show(board, 3, 3)}

    """
  end
end
