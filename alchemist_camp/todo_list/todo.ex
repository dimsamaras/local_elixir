defmodule Todo do
  def start do
    input =
      IO.gets("L)oad csv or N)ew file?\n")
      |> String.trim()
      |> String.downcase()

    case input do
      "n" -> create_initial_todo()
      "l" -> load_csv()
      _ -> start()
    end
  end

  def add_todo(data, titles) do
    name = get_item_name(data)
    fields = Enum.map(titles, &field_from_user/1)
    new_todo = %{name => Enum.into(fields, %{})}
    IO.puts(~s(New todo "#{name}" added.))
    new_data = Map.merge(data, new_todo)
    get_command(new_data)
  end

  def create_header(headers \\ []) do
    case IO.gets("Add field: ") |> String.trim() do
      "" -> headers
      header -> create_header([header | headers])
    end
  end

  def create_headers() do
    IO.puts(
      "What data should each todo have? \n" <>
        "enter field names one by one and an empty line when you're done"
    )

    create_header()
  end

  def create_initial_todo do
    titles = create_headers()
    data = %{}
    add_todo(data, titles)
  end

  def delete_todo(data) do
    todo =
      IO.gets("Which todo would you like to delete?\n")
      |> String.trim()

    if Map.has_key?(data, todo) do
      IO.puts("ok.")
      new_map = Map.drop(data, [todo])
      IO.puts("#{todo} has been delete")
      get_command(new_map)
    else
      IO.puts("There is no Todo named #{todo}!")
      show_todos(data, false)
      delete_todo(data)
    end
  end

  def field_from_user(name) do
    field_value = IO.gets("#{name}: ") |> String.trim()
    {name, field_value}
  end

  def get_command(data) do
    prompt = """
    Type the first letter of the command you want to ru
    R)ead Todos    A)dd a Todo    D)elete a Todo
    L)oad a .csv    S)ave a .csv    Q)uit
    """

    command =
      IO.gets(prompt)
      |> String.trim()
      |> String.downcase()

    titles = get_fields(data)

    case command do
      "r" -> show_todos(data)
      "a" -> add_todo(data, titles)
      "d" -> delete_todo(data)
      "l" -> load_csv()
      "s" -> save_csv(data)
      "q" -> "Goodbye"
      _ -> get_command(data)
    end
  end

  def get_fields(data) do
    data_head_key =
      data
      |> Map.keys()
      |> hd

    Map.keys(data[data_head_key])
  end

  def get_item_name(data) do
    name = IO.gets("Enter name of new todo: ") |> String.trim()

    if Map.has_key?(data, name) do
      IO.puts("Todo with that name already exists \n")
      get_item_name(data)
    else
      name
    end
  end

  def load_csv() do
    filename =
      IO.gets("Name of .csv to load: ")
      |> String.trim()

    read(filename)
    |> parse
    |> get_command
  end

  def read(filename) do
    case File.read(filename) do
      {:ok, body} ->
        body

      {:error, reason} ->
        IO.puts(~s(Could not open file "#{filename}"))
        IO.puts("#{:file.format_error(reason)}")
        start()
    end
  end

  def parse(file_text) do
    [header | lines] = String.split(file_text, ~r{(\r\n|\n|\r)})
    titles = tl(String.split(header, ","))
    parse_lines(lines, titles)
  end

  def parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, built ->
      [name | fields] = String.split(line, ",")

      if Enum.count(fields) == Enum.count(titles) do
        line_data =
          Enum.zip(titles, fields)
          |> Enum.into(%{})

        Map.merge(built, %{name => line_data})
      else
        built
      end
    end)
  end

  def prepare_csv(data) do
    headers = ["Item" | get_fields(data)]
    items = Map.keys(data)

    item_rows =
      Enum.map(items, fn item ->
        [item | Map.values(data[item])]
      end)

    rows = [headers | item_rows]
    row_strings = Enum.map(rows, &Enum.join(&1, ","))
    Enum.join(row_strings, "\n")
  end

  def save_csv(data) do
    filename = IO.gets("Name of .csv to save: ") |> String.trim()
    filedata = prepare_csv(data)

    case File.write(filename, filedata) do
      :ok ->
        IO.puts("csv saved")
        get_command(data)

      {:error, reason} ->
        IO.puts(~s(Could not save file))
        IO.puts(~s(#{:file.format_error(reason)}\n))
        get_command(data)
    end
  end

  def show_todos(data, next_command? \\ true) do
    items = Map.keys(data)
    IO.puts("You have the following todos:\n")
    Enum.each(items, fn item -> IO.puts(item) end)
    IO.puts("\n")

    if next_command? do
      get_command(data)
    end
  end
end
