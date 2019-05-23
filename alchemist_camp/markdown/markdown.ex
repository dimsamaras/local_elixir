defmodule MiniMarkdown do
    def to_html(text) do
        text         
            |> h2
            |> h1
            |> p
            |> bold
            |> italics
            |> small
            |> big
            |> create_file
    end

    def italics(text) do
        Regex.replace(~r/\*(.*)\*/, text, "<em>\\1</em>")
    end

    def bold(text) do
        Regex.replace(~r/\*\*(.*)\*\*/, text, "<strong>\\1</strong>")
    end

    def p(text) do
        Regex.replace(~r/(\r\n|\r|\n|^)+([^#<][^\r\n]+)((\r\n|\r|\n)+$)?/, text, "<p>\\2</p>")
    end

    def test_str do

        """
        # this is the title h1

        ## this is the subtitle h2

        I *so* enjoy learning Elixir the functional programming is **quite awesome**!!!

        What do you think?

        blah blah blah

        1) One
        2) Two
        3) Three

        This is  ++BIG++

        This is --small.--
        """        
    end

    def h1(text) do
        Regex.replace(~r/(\r\n|\r|\n|^)\# +([^#][]^\n\r]+)/, text, "<h1>\\2</h1>")

    end

    def h2(text) do
        Regex.replace(~r/(\r\n|\r|\n|^)\#\# +([^#][]^\n\r]+)/, text, "<h2>\\2</h2>")
    end

    def small(text) do
        Regex.replace(~r/\+\+(.*)\+\+/, text, "<big>\\1</big>")
    end

    def big(text) do
        Regex.replace(~r/\-\-(.*)\-\-/, text, "<small>\\1</small>")
    end

    def create_file(text) do
        File.write("output.html", text)
    end
end