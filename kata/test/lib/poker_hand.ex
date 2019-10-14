defmodule PokerHand do
  @straight_flush 9
  @four_of_a_kind 8
  @full_house 7
  @flush 6
  @straight 5
  @three_of_a_kind 4
  @two_pairs 3
  @one_pair 2
  @high_card 1

  @type card :: String.t()
  @type hand :: list(card)
  @type annotated_hand :: {hand, pos_integer, pos_integer} # {hand, rank, score}

  @result %{win: 1, loss: 2, tie: 3}

  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  require Logger

  @spec compare(String.t(), String.t()) :: list(hand)
  def compare(player, opponent) do

    hands = [~w(#{player}), ~w(#{opponent})]
    annotated_hands = Enum.map(hands, &annotate_hand/1)
    # best_rank = best_rank(annotated_hands)
    # best_ranked_hands = Enum.filter(annotated_hands, fn({_,r,_}) -> r == best_rank end)
    # best_score = best_score(best_ranked_hands)

    # Logger.debug("annotated_hands: #{inspect annotated_hands}")
    [{p, rank_p, score_p}, {o, rank_o, score_o}] = annotated_hands

    cond do
      rank_p > rank_o -> @result.win
      rank_p < rank_o -> @result.loss
      rank_p == rank_o ->
        cond do
          score_p == score_o -> @result.tie
          score_p > score_o -> @result.win
          score_p < score_o -> @result.loss
        end
    end

    # Logger.debug("rank: #{inspect best_ranked_hands}")
    # Logger.debug("score: #{inspect best_score}")

    # [best | _] = best_ranked_hands
    # |> Enum.filter(fn({_,_,s}) -> s == best_score end)
    # |> Enum.map(fn({h,_,_}) -> h end)

    # Enum.join(best, " ")

  end

  @spec annotate_hand(hand) :: annotated_hand
  defp annotate_hand(hand) do
    [a, b, c, d, e] = sorted = hand |> Enum.map(&number/1) |> Enum.sort()

    cond do
      is_straight(sorted) and is_flush(hand) ->
        {hand, @straight_flush, score(sorted, @straight_flush)}
      group_and_count_cards(sorted) == [4, 1] ->
        {hand, @four_of_a_kind, score(sorted, @four_of_a_kind)}
      group_and_count_cards(sorted) == [3, 2] ->
        {hand, @full_house, score(sorted, @full_house)}
      is_flush(hand) ->
        {hand, @flush, e * 100000 + d * 10000 + c * 1000 + b * 100 + a}
      is_straight(sorted) ->
        {hand, @straight, score(sorted, @straight)}
      group_and_count_cards(sorted) == [3, 1, 1] ->
        {hand, @three_of_a_kind, score(sorted, @three_of_a_kind)}
      group_and_count_cards(sorted) == [2, 2, 1] ->
        {hand, @two_pairs, score(sorted, @two_pairs)}
      group_and_count_cards(sorted) == [2, 1, 1, 1] ->
        {hand, @one_pair, score(sorted, @one_pair)}
      true ->
        {hand, @high_card, e * 100000 + d * 10000 + c * 1000 + b * 100 + a}
    end
   end

  @spec is_straight(list(pos_integer)) :: boolean
  defp is_straight([a, b, c, d, e]) when e == d+1 and e == c+2 and e == b+3 and e == a+4, do: true
  defp is_straight([2, 3, 4, 5, 14]), do: true
  defp is_straight(_), do: false

  @spec is_flush(hand) :: boolean
  defp is_flush(hand) do
    case Enum.map(hand, &String.last/1) do
      [color, color, color, color, color] -> true
      [_, _, _, _, _] -> false
    end
  end

  @spec group_and_count_cards(hand) :: list(pos_integer)
  defp group_and_count_cards(hand) do
    hand
    |> Enum.group_by(&(&1))
    |> Map.values()
    |> Enum.map(fn(list) -> length(list) end)
    |> Enum.sort(&>/2)
  end

  @spec number(hand) :: pos_integer
  defp number(card) do
    case String.replace(card, ~r/[CSDH]/, "") do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "J" -> 11
      "T" -> 10
      v   -> String.to_integer(v)
    end
  end

  @spec best_rank(list(annotated_hand)) :: pos_integer
  defp best_rank(hands), do: hands |> Enum.max_by(&(elem(&1, 1))) |> elem(1)

  @spec best_score(list(annotated_hand)) :: pos_integer
  defp best_score(hands), do: hands |> Enum.max_by(&(elem(&1, 2))) |> elem(2)

  @spec score(list(pos_integer), pos_integer) :: pos_integer
  defp score([2, 3, 4, 5, 14], _), do: 5
  defp score([_, _, _, _, e], type) when type in [@straight_flush, @straight], do: e
  defp score([a, b, b, b, b], @four_of_a_kind), do: b * 100 + a
  defp score([a, a, a, a, b], @four_of_a_kind), do: a * 100 + b
  defp score([a, a, b, b, b], @full_house), do: b * 100 + a
  defp score([a, a, a, b, b], @full_house), do: a * 100 + b
  defp score([a, b, c, c, c], @three_of_a_kind), do: c * 1000 + b * 100 + a
  defp score([a, b, b, b, c], @three_of_a_kind), do: b * 1000 + c * 100 + a
  defp score([a, a, a, b, c], @three_of_a_kind), do: a * 1000 + c * 100 + b
  defp score([a, b, b, c, c], @two_pairs), do: c * 1000 + b * 100 + a
  defp score([a, a, b, c, c], @two_pairs), do: c * 1000 + a * 100 + b
  defp score([a, a, b, b, c], @two_pairs), do: b * 1000 + a * 100 + c
  defp score([a, b, c, d, d], @one_pair), do: d * 10000 + c * 1000 + b * 100 + a
  defp score([a, b, c, c, d], @one_pair), do: c * 10000 + d * 1000 + b * 100 + a
  defp score([a, b, b, c, d], @one_pair), do: b * 10000 + d * 1000 + c * 100 + a
  defp score([a, a, b, c, d], @one_pair), do: a * 10000 + d * 1000 + c * 100 + b
end
