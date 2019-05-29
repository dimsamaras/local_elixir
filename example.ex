defmodule Example do

  def explode, do: exit(:ciao)

  def add(a, b) do
    IO.puts(a + b)
  end

  def listen do
    receive do
      {:ok, "Hello"} -> IO.puts("World")
      {:ok, :exit} -> explode
    end
    listen
  end

  def meJulie do
    __MODULE__
  end

end
