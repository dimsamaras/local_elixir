# TODO: Replace examples and use TDD development by writing your own tests

defmodule PokerHandTest do
  use ExUnit.Case

  @result %{win: 1, loss: 2, tie: 3}

  test "Highest straight flush wins" do
    assert PokerHand.compare("2H 3H 4H 5H 6H", "KS AS TS QS JS") == @result.loss
  end
  test "Straight flush wins of 4 of a kind" do
    assert PokerHand.compare("2H 3H 4H 5H 6H", "AS AD AC AH JD") == @result.win
  end
  test "Highest 4 of a kind wins" do
    assert PokerHand.compare("AS AH 2H AD AC", "JS JD JC JH 3D") == @result.win
  end
  test "4 Of a kind wins of full house" do
    assert PokerHand.compare("2S AH 2H AS AC", "JS JD JC JH AD") == @result.loss
  end
  test "Full house wins of flush" do
    assert PokerHand.compare("2S AH 2H AS AC", "2H 3H 5H 6H 7H") == @result.win
  end
  test "Highest flush wins" do
    assert PokerHand.compare("AS 3S 4S 8S 2S", "2H 3H 5H 6H 7H") == @result.win
  end
  test "Flush wins of straight" do
    assert PokerHand.compare("2H 3H 5H 6H 7H", "2S 3H 4H 5S 6C") == @result.win
  end
  test "Equal straight is tie" do
    assert PokerHand.compare("2S 3H 4H 5S 6C", "3D 4C 5H 6H 2S") == @result.tie
  end
  test "Straight wins of three of a kind" do
    assert PokerHand.compare("2S 3H 4H 5S 6C", "AH AC 5H 6H AS") == @result.win
  end
  test "3 Of a kind wins of two pair" do
    assert PokerHand.compare("2S 2H 4H 5S 4C", "AH AC 5H 6H AS") == @result.loss
  end
  test "2 Pair wins of pair" do
    assert PokerHand.compare("2S 2H 4H 5S 4C", "AH AC 5H 6H 7S") == @result.win
  end
  test "Highest pair wins" do
    assert PokerHand.compare("6S AD 7H 4S AS", "AH AC 5H 6H 7S") == @result.loss
  end
  test "Pair wins of nothing" do
    assert PokerHand.compare("2S AH 4H 5S KC", "AH AC 5H 6H 7S") == @result.loss
  end
  test "Highest card loses" do
    assert PokerHand.compare("2S 3H 6H 7S 9C", "7H 3C TH 6H 9S") == @result.loss
  end
  test "Highest card wins" do
    assert PokerHand.compare("4S 5H 6H TS AC", "3S 5H 6H TS AC") == @result.win
  end
  test "Equal cards is tie" do
    assert PokerHand.compare("2S AH 4H 5S 6C", "AD 4C 5H 6H 2C") == @result.tie
  end
end
