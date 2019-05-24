
  # suits_nums = Enum.to_list 1..10
  # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  # suits_letters  = [J,Q,K,A]
  # [J, Q, K, A]
  # suits = Enum.concat(suits_nums, suits_letters)
  # [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K, A]
  # ranks = ["Hearts", "Spades", "Diamonds", "Clubs"]
  # ["Hearts", "Spades", "Squares", "Leafs"]
  # for x <- suits, y <- ranks, into: MapSet.new(), do: %{suit: x, rank: y}

defmodule Cards do

  def new_deck(option \\ %{}) do
    suits  = ~w(Hearts, Spades, Diamonds, Clubs)
    ranks  = range_to_string(1..10) ++ ~w(Jack , Queen, King, Ace)
    for r <- ranks, s <- suits, do: r <> " of " <> s
  end

  def range_to_string(range), do: Enum.map(range, &Integer.to_string/1)
end
