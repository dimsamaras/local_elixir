defmodule FibTest do
  use ExUnit.Case
  doctest Fib

  test "naive fibonacci base cases" do
    assert Fib.naive(1) == 1
    assert Fib.naive(2) == 1
  end

  test "naive fib other numbers" do 
    assert Fib.naive(6) == 8
    assert Fib.naive(9) == 34
    assert Fib.naive(17) == 1597
  end

  test "faster fibonacci base cases" do
    assert Fib.faster(1) == 1
    assert Fib.faster(2) == 1
  end

  test "faster fib other numbers" do 
    assert Fib.faster(6) == 8
    assert Fib.faster(9) == 34
    assert Fib.faster(17) == 1597
  end

  @tag :pending
  test "faster fib large number" do 
    assert Fib.faster(150) == 9969216677189303386214405760200
    assert Fib.faster(223) == 17978720198565577104981084195586024127087428957
  end

end  