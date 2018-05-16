# ExHash
ExHash is a simple Command-Line Interface (CLI) for hashing text and files.

## Installation
The only requirement for running ExHash is [Erlang](http://erlang.org/doc/man/erlang.html). Downloads of the pre-built
CLI are available via the [Releases](https://github.com/zcking/ex_hash/releases) tab.

## Building
To build ExHash on your local machine, first pull down the source code to your
machine:  
```
git clone https://github.com/zcking/ex_hash.git .
cd ex_hash
```

Then, assuming you have Erlang, Elixir, and `mix` installed properly, just run
this mix task to build the CLI:  
```
mix escript.build
```

Note: you may need to fetch the dependencies first: `mix deps.get`.
