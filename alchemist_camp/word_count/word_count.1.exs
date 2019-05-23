{parsed, args, invalid} =
  ["--tail", "-wcl", "./README.md"] |>
  OptionParser.parse(
  switches: [chars: :boolean, lines: :boolean, words: :boolean, tail: :integer],
  aliases: [c: :chars, l: :lines, w: :words, t: :tail]
)

IO.inspect {parsed, args, invalid}
