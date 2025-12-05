defmodule Day5 do
  def part1(input) do
    {ranges, list} = parse_ingredients(input)
    count_within_ranges(list, ranges)
  end

  def part2(input) do
    {ranges, _} = parse_ingredients(input)

    ranges
    |> merge_ranges
    |> Enum.map(&range_size/1)
    |> Enum.sum()
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

  defp merge_ranges(ranges) do
    sorted_ranges = Enum.sort_by(ranges, fn {low, _high} -> low end)
    [first | rest] = sorted_ranges

    reducer = fn new_range, acc ->
      [unmerged | previously_merged] = acc

      merged =
        if overlaps?(unmerged, new_range) do
          [merge_range(unmerged, new_range)]
        else
          [new_range, unmerged]
        end

      merged ++ previously_merged
    end

    Enum.reduce(rest, [first], reducer)
  end

  defp overlaps?(range1, range2) do
    {low1, high1} = range1
    {low2, _high2} = range2

    if low1 <= low2 do
      low2 <= high1
    else
      overlaps?(range2, range1)
    end
  end

  defp merge_range({low1, high1}, {low2, high2}) do
    {min(low1, low2), max(high1, high2)}
  end

  defp range_size({low, high}) do
    high - low + 1
  end
end
