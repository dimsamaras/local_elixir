defmodule WordCount do

  @default_lines 10
  is_not_empty = fn x -> x != "" end

  def start(parsed, filename, invalid) do
    help_flag = Enum.member?(parsed, {:help, true})
    if (Enum.count(filename) != 1) or (invalid != []) or (help_flag) do
      show_help()
    else
      work(parsed, filename)
    end
  end

  def show_help() do
    IO.puts("""
    Usage: [filename] -[flags]
    flags
    -l --lines      displays line coufile_text = read_file(filename)nt
    -c --chars      displays character count
    -w --words      displays word count (default)
    -t --tail n     displays the last 'n' lines of the file, defaults to 10
    -h --help       displays help

    Multiple flags may be used. Example:

    somefile.txt -lc
    """)
  end

  def work(parsed, filename) do
    file_text = read_file(filename)

    flags =
      case Enum.count(parsed) do
        0 -> %{words: true}
        # _ -> Enum.map(parsed, &(elem&1, 0))
        _ -> Enum.into parsed, %{}
      end

    Enum.each(flags, fn {k, v} ->
      case k do
        :lines -> IO.puts("Lines: #{get_lines(file_text) |> Enum.count}")
        :words -> IO.puts("Words: #{get_words(file_text) |> Enum.count}")
        :chars -> IO.puts("Chars: #{get_chars(file_text) |> Enum.count}")
        :tail  -> IO.puts("Tail of file: #{get_tail(file_text, v)}")
        _ -> nil
      end
    end)

  end

  defp read_file(filename) do
    File.read!(filename)
  end

  defp get_words(text) do
      text
      |> String.split(~r{(\\n|[^\w'])+})
      |> Enum.filter(fn x -> x != "" end)
  end

  defp get_lines(text) do
    String.split(text, ~r{(\r\n|\n|\r)})
  end

  defp get_chars(text) do
      String.split(text, "")
      |> Enum.filter(fn x -> x != "" end)
  end

  defp get_tail(text, n) do
    {tail_lines, ""} = if n == true do {@default_lines, ""} else Integer.parse(n) end

    String.split(text, ~r{(\r\n|\n|\r)})
    |> Enum.take(-tail_lines)
    |> Enum.join("\n")
end

end
