defmodule RomanNumbersTest do
  alias RomanNumbers
  use ExUnit.Case

  test "should equals 21" do
    assert RomanNumbers.decode("XXI") == 21
  end

  test "should equals 1" do
    assert RomanNumbers.decode("I") == 1
  end

  test "should equals 4" do
    assert RomanNumbers.decode("IV") == 4
  end

  test "should equals 2008" do
    assert RomanNumbers.decode("MMVIII") == 2008
  end

  test "should equals 1666" do
    assert RomanNumbers.decode("MDCLXVI") == 1666
  end
end
