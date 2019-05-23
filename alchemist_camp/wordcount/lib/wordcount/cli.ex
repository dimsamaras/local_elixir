defmodule WordCount.CLI do

  def main(args) do
    {parsed, args, invalid} =
      OptionParser.parse(
      args,
      strict: [chars: :boolean, lines: :boolean, words: :boolean, tail: nil, help: :boolean],
      aliases: [c: :chars, l: :lines, w: :words, t: :tail, h: :help]
    )

    IO.inspect {parsed, args, invalid}
    WordCount.start(parsed, args, invalid)
  end

end
