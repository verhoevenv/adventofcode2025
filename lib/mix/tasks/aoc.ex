defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    dayModule =
      case args do
        ["1"] -> Day1
        ["2"] -> Day2
        ["3"] -> Day3
        ["4"] -> Day4
        ["5"] -> Day5
        ["6"] -> Day6
      end

    input =
      IO.stream(:stdio, :line)
      |> Enum.join("")

    output1 = dayModule.part1(input)
    IO.puts(output1)
    output2 = dayModule.part2(input)
    IO.puts(output2)
  end
end
