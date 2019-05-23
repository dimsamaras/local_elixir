defmodule GreetingGame do
  @author "Danilo"
  def greet do
    name = IO.gets("What is your first name?\n") |> String.trim()

    case name do
      @author -> IO.puts("Wow, that is the name of my programmer!")
      _ -> IO.puts("Hello #{name} nice to meet you")
    end
  end
end
