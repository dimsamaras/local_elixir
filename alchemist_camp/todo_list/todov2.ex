defmodule TodoTwo do
  def start do
    load_csv()
  end

  def load_csv() do
    filename = IO.gets("Filename to open: ") |> String.trim()

    read(filename)
    |> parse
  end

  def read(filename) do
    response = File.read(filename)

    case response do
      {:ok, data_string} -> data_string
      {:error, reason} -> IO.puts(:file.format_error(reason))
    end
  end

  def parse(data_string) do
    [header_string | todos_lines] = String.split(data_string, ~r(/\n|\r\n|\r/))

    [_ | header_titles] = String.split(header_string, ",")

    Enum.reduce(todos_lines, %{}, fn todo_string, accum_map ->
      [todo_title | todo_items] = String.split(todo_string, ",")

      if Enum.count(header_titles) == Enum.count(todo_items) do
        todo_map =
          Enum.zip(header_titles, todo_items)
          |> Enum.into(%{})

        Map.put(accum_map, todo_title, todo_map)
      else
        accum_map
      end
    end)
  end
end
