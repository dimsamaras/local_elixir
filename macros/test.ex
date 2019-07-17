defmodule Test do
  import Tracer

  deftraceable my_fun(a, b) when a < b do
    a * b
  end

  deftraceable my_fun(a, b) do
    a / b
  end
end
