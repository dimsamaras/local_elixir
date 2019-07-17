# local_elixir
Getting started with elixir programming lang

__require vs import__

When we require a module, we instruct the Elixir to hold the compilation of the current module until the required module is compiled and loaded into the compiler run-time (the Erlang VM instance where compiler is running). We can only call <some> macro when the <Some> module is fully compiled, and available to the compiler.

Using import has the same effect but it additionally lexically imports all exported functions and macros, making it possible to write some instead of Some.some.
