defmodule Tictac.CLI do
  alias Tictac.{State, CLI}

  def play() do
    Tictac.start(&CLI.handle/2)
  end

  def handle(%State{status: :initial}, :get_player) do
    IO.gets("Which player should start, x or o?")
    |> String.trim
    |> String.to_atom
  end

  def handle(%State{status: :playing} = state, :request_move) do
      display_board(state.board)
      IO.puts("What's #{state.turn}'s next move")
      # {row, _}
      row = IO.gets("Row: ") |> trimmed_int
      col = IO.gets("Column: ") |> trimmed_int
      {row, col}
  end

  def handle(%State{status: :game_over} = state, _) do
      display_board(state.board)
      case state.winner do
        :tie -> "Blah blah, it is a tie"
        _    -> "Player #{state.winner} won!!!"
      end
  end

  defp show(board, r, c) do
    [item] = for {%{row: row,col: col}, v} <- board,
              row == r, col == c,
              do: v
    if item == :empty, do: " ", else: to_string(item)
  end

  defp trimmed_int(str) do
    # case Integer.parse(str) do
    #   {:ok, n} -> n
    #   error    -> error
    # end

    str |> String.trim |> String.to_integer
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
