defmodule Fib.Timer do
    def time(func, arglist) do
        start = Time.utc_now
        apply(func, arglist)
        Time.diff(Time.utc_now, start, :millisecond)
    end  
end
