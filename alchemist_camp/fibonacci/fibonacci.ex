defmodule Fibonacci do
  def number_at(num \\ 2, current_map \\ %{"1" => 1, "2" => 1}) do
    datetime1 = DateTime.utc_now()
    key = to_string(num)

    case Map.get(current_map, key) do
      nil ->
        current_length = Enum.count(current_map)
        last_key = to_string(current_length)
        second_last_key = to_string(current_length - 1)
        last_value = Map.get(current_map, last_key)
        second_last_value = Map.get(current_map, second_last_key)
        new_value = last_value + second_last_value
        new_key = to_string(current_length + 1)
        new_map = Map.merge(current_map, %{new_key => new_value})
        number_at(num, new_map)

      num ->
        datetime2 = DateTime.utc_now()

        IO.puts(
          "The #{num}th number of fibonacci is #{num} and it took #{
            DateTime.diff(datetime2, datetime1, :millisecond)
          } milliseconds"
        )
    end
  end
end
