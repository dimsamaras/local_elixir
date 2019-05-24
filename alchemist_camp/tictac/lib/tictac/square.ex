defmodule Tictac.Square do
  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @board_size 1..3

  def new(row, col) when row in @board_size and col in @board_size do
    {:ok, %Tictac.Square{row: row, col: col}}
  end

  def new(_row, _col), do: {:error, :invalid_square}

  def squares do
    for row <- @board_size, col <- @board_size, into: MapSet.new(), do: %Tictac.Square{row: row, col: col}
  end

  def new_board do
    for s <- squares(), into: %{}, do: {s, :empty}
  end

end
