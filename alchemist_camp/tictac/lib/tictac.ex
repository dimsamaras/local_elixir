defmodule Tictac do
  @players [:x, :o]

  def check_player(player) do
    case player in @players do
      true -> {:ok, :player_valid}
      _    -> {:error, :player_invalid}
    end
  end

  def place_piece(board, place, player) do
    case board[place] do
      nil     -> {:error, :invalid_location}
      :x      -> {:error, :occupied}
      :o      -> {:error, :occupied}
      :empty  -> {:ok, %{board | place => player}}
    end
  end

  def play_at(board, row, col, player) do
    with {:ok, valid_player} <- check_player(player),
         {:ok, square}       <- Square.new(col, row),
         {:ok, new_board}    <- place_piece(board, square, player),
         do: new_board
  end

end
