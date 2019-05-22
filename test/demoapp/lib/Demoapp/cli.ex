defmodule Demoapp.CLI do
  def main(args \\ []) do
    args
    |> parse_args
    |> response
    |> IO.puts()
  end

  defp parse_args(args) do
    {opts, word, _} =
      args
      |> OptionParser.parse(switches: [upcase: :boolean, length: :boolean, split: :boolean])

    IO.inspect opts #here I just print the options

    {opts, List.to_string(word)}
  end

  defp response({opts, word}) do
    # if opts[:upcase], do: String.upcase(word), else: word
    case opts do
      [upcase: true] -> String.upcase(word)
      [length: true] -> String.length(word)
      [split: true]  -> String.codepoints(word) |> Enum.chunk(1) |> Enum.map(&Enum.join/1)
      _               -> word
    end
  end
end
