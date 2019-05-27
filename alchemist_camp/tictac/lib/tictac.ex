defmodule Tictac do
  alias Tictac.{Square, State}
  @players [:x, :o]

  def get_players, do: @players

  def check_player(player) do
    case player in @players do
      true -> {:ok, :player_valid}
      _    -> {:error, :player_invalid}
    end
  end

  def start(ui) do
    with {:ok, game} <- State.new(ui),
         player      <- ui.(game, :get_player),
         {:ok, game} <- State.event(game, {:choose_p1, player}),
    do: handle(game),
    else: (error -> error)
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
    with {:ok, :player_valid} <- check_player(player),
         {:ok, square}       <- Square.new(row, col),
         {:ok, new_board}    <- place_piece(board, square, player),
      do: {:ok, new_board},
      else: (error -> error)
  end

  defp check_for_win(board, player) do
    cols = Enum.map(1..3, &get_col(board, &1))
    rows = Enum.map(1..3, &get_row(board, &1))
    diagonals = get_diagonals(board)
    win? = Enum.any?(cols++rows++diagonals, &won_line(&1, player))
    if win?, do: player, else: false
  end

  defp game_over?(game) do
    board_full = Enum.all?(game.board, fn {_,v} -> v != :empty end)
    if board_full or game.winner do
      :game_over
    else
      :not_over
    end
  end

  def get_col(board, col) do
    for {%{row: _, col: c}, v} <- board, c == col , do: v
  end

  def get_row(board, row) do
    for {%{row: r, col: _}, v} <- board, r == row , do: v
  end

  def get_diagonals(board) do
    [(for {%{row: r, col: c}, v} <- board, c == r , do: v),
      (for {%{row: r, col: c}, v} <- board, c + r == 4 , do: v)
    ]
  end

  def won_line(line, player), do: Enum.all?(line, &(player == &1))

  def handle(%{status: :playing} = game) do
    player = game.turn
    with {row, col}   <- game.ui.(game, :request_move),
      {:ok, board}    <- play_at(game.board, row, col, game.turn),
      {:ok, game}     <- State.event(%{game | board: board}, {:play, game.turn}),
      won?            <- check_for_win(board, player),
      {:ok, game}     <- State.event(game, {:check_for_winner, won?}),
      over?           <- game_over?(game),
      {:ok, game}     <- State.event(game, {:game_over?, over?}),
    do: handle(game),
    else: (error -> error)
  end

  def handle (%{status: :game_over} = game) do
    game.ui.(game, :game_over)
  end
end
