defmodule Fib.TimerTest do
  use ExUnit.Case
  alias Fib
  alias Fib.Timer
 
  test "Timer in milliseconds" do
    assert is_number Timer.time(&Fib.naive/1, [10])
  end

  test "Timer in milliseconds on arity >1 function" do
    assert is_number Timer.time(&Fib.naive/2, [2, 3])
  end

  test "faster func is faster than naive" do
    naive_time = Timer.time(&Fib.naive/1, [10])
    faster_time = Timer.time(&Fib.faster/1, [10])

    assert faster_time < naive_time
  end

end