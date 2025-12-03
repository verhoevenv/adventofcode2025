defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    dayModule =
      case args do
        ["1"] -> Day1
      end

    input =
      IO.stream(:stdio, :line)
      |> Enum.join("")

    output = dayModule.part1(input)
    IO.puts(output)
  end
end
