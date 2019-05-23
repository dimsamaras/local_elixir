user_input =
  "Files to count words from (h for help): "
  |> IO.gets()
  |> String.trim()

is_not_empty = fn my_string -> my_string != "" end

if user_input == "h" do
  IO.puts("""
  Usage: [filename] -[flags]
  flags
  -l displays line count
  -c displays character count
  -w displays word count (default)
  Multiple flags may be used. Example:

  somefile.txt -lc
  """)
else
  filename_flags = String.split(user_input, " -")

  filename =
    List.first(filename_flags)
    |> String.trim()

  flags =
    case Enum.at(filename_flags, 1) do
      nil ->
        ["w"]

      chars ->
        String.split(chars, "")
        |> Enum.filter(is_not_empty)
    end

  file_text = File.read!(filename)
  # regular expression inside ~r{}
  # splits by anything that is \n
  # OR (that is the |)
  # anything that is not a word or apostrophe
  # [ˆ] means is not
  # the plus means treat all the words or apostrophes is a row as one thing
  lines = String.split(file_text, ~r{(\r\n|\n|\r)})

  words =
    file_text
    |> String.split(~r{(\\n|[^\w'])+})
    |> Enum.filter(is_not_empty)

  chars =
    String.split(file_text, "")
    |> Enum.filter(is_not_empty)

  Enum.each(flags, fn flag ->
    case flag do
      "l" -> IO.puts("Lines: #{Enum.count(lines)}")
      "w" -> IO.puts("Words: #{Enum.count(words)}")
      "c" -> IO.puts("Chars: #{Enum.count(chars)}")
      _ -> nil
    end
  end)

  IO.inspect(words)
  IO.inspect(chars)
  IO.inspect(lines)
end
