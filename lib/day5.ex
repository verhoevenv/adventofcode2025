defmodule Day5 do
  def part1(input) do
    {ranges, list} = parse_ingredients(input)
    count_within_ranges(list, ranges)
  end

  def part2(_input) do
    "todo"
  end

  defp parse_ingredients(input) do
    [first, second] = String.split(input, "\n\n")
    ranges = Enum.map(String.split(first, "\n"), &parse_range/1)
    list = Enum.map(String.split(second, "\n"), &String.to_integer/1)
    {ranges, list}
  end

  defp parse_range(input) do
    input
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp count_within_ranges(list, ranges) do
    list
    |> Enum.filter(&within_ranges?(&1, ranges))
    |> Enum.count()
  end

  defp within_ranges?(number, ranges) do
    Enum.any?(ranges, fn range -> within_range?(number, range) end)
  end

  defp within_range?(number, range) do
    {low, high} = range
    number >= low && number <= high
  end
end
