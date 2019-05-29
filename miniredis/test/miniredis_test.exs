defmodule MiniredisTest do
  use ExUnit.Case
  doctest Miniredis

  test "greets the world" do
    assert Miniredis.hello() == :world
  end
end
