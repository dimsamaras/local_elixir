defmodule Assertions do
  defmacro assert({operator, _, [lhs, rhs]} = expr)
           when operator in [:==, :<, :>, :<=, :>=, :===, :=~, :!==, :!=, :in] do
    quote do
      left = unquote(lhs)
      right = unquote(rhs)
      result = unquote(operator)(left, right)

      unless result do
        IO.puts("Assertion with == failed!")
        IO.puts("code: #{unquote(Macro.to_string(expr))}")
        IO.puts("lhs: #{left}")
        IO.puts("rhs: #{right}")
      end

      result
    end
  end
end
