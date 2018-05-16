defmodule ExHash.CLI do

  defp switches() do
    [
      file: :string,
      text: :string,
      alg: :string,
      help: :boolean,
    ]
  end

  defp aliases() do
    [
      f: :file,
      t: :text,
      a: :alg,
      h: :help,
    ]
  end

  defp algorithms() do
    [
      "sha",
      "sha224",
      "sha256",
      "sha384",
      "sha512",
      "md4",
      "md5",
      "ripemd160",
    ]
  end

  defp help_msg() do
    """
    Welcome to ExHash, a simple CLI for hashing text and files!

    File Usage:
      ./ex_hash (-f|--file) <filepath> (-a|--alg) <algorithm>

    Text Usage:
      ./ex_hash (-t|--text) <text> (-a|--alg) <algorithm>

    Display this Help Message:
      ./ex_hash (-h|--help)

    Supported Hash Algorithms:
    """ <> Enum.join(Enum.map(algorithms(), &(" - #{&1}\n")))
  end

  def main(args) do
    {opts, _, _} = OptionParser.parse(args, switches: switches(), aliases: aliases())

    opts = Enum.into(opts, %{})

    case opts do
      %{help: true} ->
        IO.puts(help_msg())
        System.halt(1)

      %{file: file_name, alg: alg} ->
        hash_file(file_name, alg)

      %{text: text, alg: alg} ->
        hash_text(text, alg)

      %{file: _} ->
        IO.puts("You must specify a hashing algorithm to use")
        IO.puts("Here are the available hashing algorithms:")
        algorithms() |> Enum.map(&(IO.puts(" - #{&1}")))
        System.halt(1)

      %{text: _} ->
        IO.puts("You must specify a hashing algorithm to use")
        IO.puts("Here are the available hashing algorithms:")
        algorithms() |> Enum.map(&(IO.puts(" - #{&1}")))
        System.halt(1)

      %{alg: _} ->
        IO.puts("You must specify either a file or text to hash")
        System.halt(1)

      _ ->
        IO.puts(help_msg())
        System.halt(1)
    end
  end

  def check_file(file_name) do
    full_path = Path.expand(file_name)

    exists = File.exists?(full_path)

    unless exists do
      IO.puts("File #{full_path} does not exist")
      System.halt(1)
    end
  end

  def check_alg(alg) do
    unless alg in algorithms() do
      IO.puts("Hashing algorithm #{alg} not supported.")
      IO.puts("Available algorithms are:")
      algorithms() |> Enum.map(&(IO.puts(" - #{&1}")))
      System.halt(1)
    end
  end

  def hash_file(file_name, algorithm) do
    check_file(file_name)
    check_alg(algorithm)

    alg = String.to_atom(algorithm)

    IO.puts("hashing #{file_name} with #{algorithm} algorithm...")
    data = File.read!(Path.expand(file_name))
    hash = :crypto.hash(alg, data) |> Base.encode16 |> String.downcase
    IO.puts("\n#{hash}")
  end

  def hash_text(text, algorithm) do
    check_alg(algorithm)
    alg = String.to_atom(algorithm)

    IO.puts("hashing #{text} with #{algorithm} algorithm...")
    hash = :crypto.hash(alg, text) |> Base.encode16 |> String.downcase
    IO.puts("\n#{hash}")
  end

end
