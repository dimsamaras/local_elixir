defmodule MiniMarkdown do
  def to_html(text) do
    text
    |> h1
    |> h2
    |> p
    |> big
    |> small
    |> bold
    |> italics
  end

  def bold(text) do
    Regex.replace(~r/\*\*([^\*\*]*)\*\*/, text, "<strong>\\1</strong>")
  end

  def big(text) do
    Regex.replace(~r/\+\+([^\+\+]*)\+\+/, text, "<big>\\1</big>")
  end

  def h1(text) do
    Regex.replace(~r/(\r\n|\r|\n|^)# +([^#][^\n\r]+)/, text, "<h1>\\2</h1>")
  end

  def h2(text) do
    Regex.replace(~r/(\r\n|\r|\n|^)## +([^#][^\n\r]+)/, text, "<h2>\\2</h2>")
  end

  def italics(text) do
    Regex.replace(~r/\*([^\*]*)\*/, text, "<em>\\1</em>")
  end

  def p(text) do
    Regex.replace(~r/(\r\n|\r|\n|^)+([^#<][^\r\n]+)((\r\n|\r|\n)+$)?/, text, "<p>\\2</p>")
  end

  def small(text) do
    Regex.replace(~r/--([^--]*)--/, text, "<small>\\1</small>")
  end

  def test_string do
    """
    # Test

    ## Test 2

    I *so* enjoy --eating-- that ++and++ the **hot** sauce was amazing!

    What do you think?

    asd
    """
  end
end
