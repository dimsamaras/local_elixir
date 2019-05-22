defmodule Fibonacci do
    def time(func, arg) do
        start = Time.utc_now
        func.(arg)
        Time.diff(Time.utc_now, start, :millisecond)
    end
    
    def compare(n \\ 40) do
        IO.puts("Naive: #{time(&naive/1, n)}")
        IO.puts("Faster: #{time(&faster/1, n)}")
    end

    def calculate(n) when n < 0, do: IO.puts "Try a positive sqquence number"
    def calculate(n) do 
        if n<=1 do
            n
        else
            calculate(n-1) + calculate(n-2)
        end
    end    

    def naive(1), do: 1
    def naive(0), do: 0
    def naive(2), do: 1
    def naive(n) do
        naive(n-1)+naive(n-2)
    end

    def faster(n), do: faster(n, 0, 1)
    def faster(1,_acc1, acc2), do: acc2
    def faster(n, acc1, acc2) do
        faster(n-1, acc2, acc1 + acc2)
    end
end
