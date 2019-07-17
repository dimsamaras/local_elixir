defmodule Tracer do
  defmacro trace(expression_ast) do
    string_representation = Macro.to_string(expression_ast)

    quote do
      result = unquote(expression_ast)
      Tracer.print(unquote(string_representation), result)
      result
    end
  end

  def print(string_representation, result) do
    IO.puts("Result of #{string_representation}: #{result}")
  end

  defmacro deftraceable(head, body) do
    # Extract function name and arguments
    {fun_name, args_ast} = name_and_args(head)

    quote do
      def unquote(head) do
        file = __ENV__.file
        line = __ENV__.line
        module = __ENV__.module

        # Inject function name and arguments into AST
        function_name = unquote(fun_name)
        passed_args = unquote(args_ast) |> Enum.map(&inspect/1) |> Enum.join(",")

        # Inject function body into the AST
        result = unquote(body[:do])

        # Print trace info"
        loc = "#{file}(line #{line})"
        call = "#{module}.#{function_name}(#{passed_args}) = #{inspect(result)}"
        IO.puts("#{loc} #{call}")

        result
      end
    end
  end

  defp name_and_args({:when, _, [short_head | _]}) do
    name_and_args(short_head)
  end

  defp name_and_args(short_head) do
    Macro.decompose_call(short_head)
  end
end
