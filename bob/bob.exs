defmodule Bob do
  def hey(input) do
    cond do
      nothing?(input) ->
        "Fine. Be that way!"
      yell_the_question?(input) ->
        "Calm down, I know what I'm doing!"  
      question?(input) ->
        "Sure." 
      shout?(input) ->
        "Whoa, chill out!" 
      true ->
        "Whatever."
    end
  end

  def question?(input), do: String.last(input) == "?"

  def shout?(input), do: String.upcase(input) == input && string_only_letters?(input)

  def nothing?(input), do: String.trim(input) == ""

  def yell_the_question?(input), do:  String.upcase(input) == input && string_only_letters?(input) && question?(input)

  def string_only_letters?(input), do: String.upcase(input) !== String.downcase(input)
  # def string_only_letters?(text), do: Regex.replace(~r(^\\p{L}\\p{N}]+) ,text , " ")
end
