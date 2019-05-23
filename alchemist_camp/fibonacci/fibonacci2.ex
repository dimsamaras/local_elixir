defmodule Fibonacci do
  def number_at(x) when x < 1 or not is_integer(x) do
    IO.puts("Use position greater than or equal to 1 and integer")
  end

  def number_at(1) do
    1
  end

  def number_at(num) do
    number_at(num, 0, 1, 1)
  end

  def number_at(num, last, second_last, position) do
    case num do
      _ when num == position ->
        last + second_last

      _ ->
        number_at(num, last + second_last, last, position + 1)
    end
  end
end
